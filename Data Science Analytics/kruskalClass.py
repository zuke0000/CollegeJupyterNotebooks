import numpy as np

class kruskalClass():
    
    ''' 
    Takes in an array, the left half and right half of it. Returns a merged and sorted version of a
    '''
    def merge(self, a,leftHalf, rightHalf):
        i = 0 # pointer for left
        j = 0 # pointer for right
        iterator = 0 # pointer for array passed in
        while (len(leftHalf) > i) and (len(rightHalf) > j):
            if (leftHalf[i] < rightHalf[j]):
                a[iterator] = leftHalf[i]
                i += 1
                iterator += 1
            else:
                a[iterator] = rightHalf[j]
                j += 1
                iterator += 1
        for k in range(i, len(leftHalf)): # equivilant of extending array for remaining values
            a[iterator] = leftHalf[k]
            iterator += 1
        for k in range(j, len(rightHalf)):
            a[iterator] = rightHalf[k]
            iterator += 1
        
        return a
    ''' 
    Takes in an array and recursively divides then merges values to return a sorted version.
    '''
    def mergesort(self,a):
        # input is a 1xk numpy array
        # output is a 1xk numpy array with elements in ascending order
        arrayLength = len(a)
        if arrayLength == 1:
            return a
        mid = arrayLength // 2 # divide and floor
        leftHalf = a.copy()[:mid] # left half of array. Use a.copy() because of numpy weirdness
        rightHalf = a.copy()[mid:]
        self.mergesort(leftHalf)
        self.mergesort(rightHalf)
        mergedValues = self.merge(a,leftHalf, rightHalf)
        return(mergedValues)
    
    
    ''' 
    Takes in a number n, creates a dictionary with the format (index : {index, 1})
    '''
    def makeUnionFind(self, n):
        
        dict = {}
        for i in range(n):
            dict[i] = np.array([i, 1])
        return dict
    ''' 
    Takes in the union structure, a first node, and second node. Returns union structure with values of dictionary changing in 3 cases
    '''
    def union(self,u,first,second):
        # cases. 
        # 1: weight of a is > b
        # 2: weight a < b
        # 3: a == b
        if (u[first][1] == u[second][1]): # CASE 3
            u[first][0] = second
            u[second][1] += u[first][1]
        
        elif (u[first][1] < u[second][1]): # CASE 2
            u[first][0] = second
            u[second][1] += u[first][1]
        
        elif (u[first][1] > u[second][1]): # CASE 1
            u[second][0] = first
            u[first][1] += u[second][1]
            
        return u
        
    ''' 
    Takes in union structure and a vertex. Recursively calls itself to return root node of v
    '''
    def find(self,u,v):
        if (u[v][0] != v):
            return(self.find(u,u[v][0])) # recursive call until we reach root node
        return (u[v][0])
    
    ''' 
    Step 1: Setup with emtpy nxn mstArray, union structure, arrayDictionary, and weights
    Step 2: Loop through indexes in A: add weights to arrayDictionary and weights array
    Step 3: Sort the weights array via mergesort
    Step 4: Loop through sorted weights, get nodes of weights via arrayDictionary. 
    Step 5: from loop in step 4, If the root nodes of weight aren't the same, union the nodes and add the weight the mstArray
    '''
    def findMinimumSpanningTree(self, A):
        n = len(A) # assumes every array is nxn
        mstArray = np.zeros(shape=(n,n))
        classUnion = self.makeUnionFind(n)
        
        arrayDictionary = {} # keeps track of weights and their index
        weights = [] # array of unique weights, gets sorted later
        for i in range(n): # loop through array indexes
            for j in range(n):
                if (A[i][j] != 0):
                    weight = A[i][j]
                    arrayDictionary[weight] = np.array([i, j])
                    weights.append(weight)
        weights = self.mergesort(weights)
        
        for weight in weights: # loop through sorted weights
            first,second = arrayDictionary[weight]
            if (self.find(classUnion,first) != self.find(classUnion,second)):
                self.union(classUnion,self.find(classUnion,first),self.find(classUnion,second))
                mstArray[first][second] = weight
        
        return mstArray