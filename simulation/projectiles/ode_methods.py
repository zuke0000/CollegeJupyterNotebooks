import numpy as np

class EulerCromer:
    def __init__(self):
        pass   
    
    def step(self,ode,t,dt,u_0):
        rhs_now = ode.rhs(t, u_0)
        new_vel = u_0[ode.split:] + dt*rhs_now[ode.split:]
        new_pos = u_0[:ode.split] + dt*new_vel
        u_1 = np.concatenate((new_pos, new_vel), axis=None)
        return u_1

class Integrator:
    def __init__(self,ode,method):
        self.ode = ode
        self.method = method
        
    def integrate(self,interval,dt,u_0):
        t_0 = interval[0]
        t_end = interval[1]
        
        times = [t_0]
        states = [u_0]
        
        t = t_0
        while t<t_end:
            dt_ = min(dt,t_end-t)
            u_1 = self.method.step(self.ode,t,dt_,u_0)
            t = t + dt_
            u_0 = u_1
            
            times.append(t)
            states.append(u_1)
            
        return np.array(times),np.array(states)

class LennardJones:
    
    def __init__(self, m=np.array([1.,1.]), n_bodies=2, sigma=1, epsilon=1, L=10):
        self.n_dof = 4*n_bodies #num of parameters in model
        self.n = n_bodies #num of particles
        self.split = 2*n_bodies #index where u splits from positions to velocities
        self.m = m #masses of particles
        self.sig = sigma
        self.eps = epsilon
        self.L = L
        
    def rhs(self,t,u):
        dudt = np.zeros(self.n_dof)
        Fx = np.zeros((self.n, self.n))
        Fy = np.zeros((self.n, self.n))
        F = np.array([Fx, Fy]) #F[0] gives x forces, F[1] gives y forces
        n = self.n
        m = self.m
        L = self.L
        eps = self.eps
        sig = self.sig

        #F = double_for(F, n, m, L, eps, sig)
        
        for i in range(self.n-1):
            for j in range(i+1,self.n):
                m_product = self.m[i]*self.m[j]
                jPos = np.array([u[j], u[j+self.n]])
                iPos = np.array([u[i], u[i+self.n]])
                r = periodic_distance(iPos, jPos, self.L)
                r_norm = np.linalg.norm(r)
                F[0,i,j] = Force(self.eps, r_norm, self.sig)/r_norm*r[0] 
                F[0,j,i] = -F[0,i,j]
                F[1,i,j] = Force(self.eps, r_norm, self.sig)/r_norm*r[1]
                F[1,j,i] = -F[1,i,j]
        
        for i in range(self.split):
            dudt[i] = u[i+self.split]
        for i in range(self.n):
            force = np.zeros(2)
            for j in range(self.n):
                force += F[:,i,j]
            dudt[i+self.split] = force[0]/self.m[i]
            dudt[i+self.split+self.n] = force[1]/self.m[i]
        return dudt

@numba.jit(nopython=True)
def periodic_distance(xi,xj,L):
    dx = xj[0] - xi[0]
    dy = xj[1] - xi[1]
    
    if dx>(0.5*L):    # If the particles are more than 1/2L apart,
        dx -= L       # go around other edge.
    elif dx<(-0.5*L): # This changes the direction (sign)
        dx += L       # and the amount to x%L
    else:
        pass
    
    if dy>(0.5*L):
        dy -= L
    elif dy<(-0.5*L):
        dy += L
    else:
        pass
    
    return np.array([dx,dy])

class Cromer:
    def __init__(self,callbacks=[]):
        self.callbacks = callbacks #array of callbacks
    
    def step(self,ode,t,dt,u_0):
        u_star = u_0 + dt*ode.rhs(t,u_0)
        for c in self.callbacks:
            u_star = c.apply(u_star)
        u_1 = u_0 + dt*ode.rhs(t,u_star)
        for c in self.callbacks:
            u_1 = c.apply(u_1)
        u_final = np.concatenate((u_1[:ode.split], u_star[ode.split:]), axis=0)
        return u_final
    
class PBCCallback:
    def __init__(self,position_indices,L):
        """ Accepts a list of which degrees of freedom in u are positions 
        (which varies depending on how you organized them) as well as a 
        maximum domain size. """
        self.position_indices = position_indices #list or int?
        self.L = L
                 
    def apply(self,u):
        # Set the positions to position modulo L
        u[self.position_indices] = u[self.position_indices] % self.L
        return u

@numba.jit(nopython=True)
def Force(eps, r, sig):
    f = -24*eps/r*(2*(sig/r)**12-(sig/r)**6)
    return f