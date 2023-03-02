class Solution:
    def isPalindrome(self, x: int) -> bool:
        string=str(x)
        
        for i in range(len(string)//2):
            
            if string[i]==string[~i]:
                continue
            else:
              return False
        
        return True
