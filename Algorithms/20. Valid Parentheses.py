class Solution:
    def isValid(self, s: str) -> bool:
        
        if len(s)%2==1:
            return False
        else:
            while len(s)!=0 and (('()' in s) or ('[]' in s) or ('{}' in s)): 
                if '()' in s:
                    s=s.replace('()','')
                if '[]' in s:
                    s=s.replace('[]','')
                if '{}' in s:
                    s=s.replace('{}','')
            
            if len(s)==0:
                return True
            else:
                return False
