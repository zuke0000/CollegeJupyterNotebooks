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