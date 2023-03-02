class Solution:
    def romanToInt(self, s: str) -> int:
        temp=0
        
        while 'IV' in s:
            s=s.replace('IV',' ')
            temp+=4
        while 'IX' in s:
            s=s.replace('IX',' ')
            temp+=9
        while 'XL' in s:
            s=s.replace('XL',' ')
            temp+=40
        while 'XC' in s:
            s=s.replace('XC',' ')
            temp+=90
        while 'CD' in s:
            s=s.replace('CD',' ')
            temp+=400
        while 'CM' in s:
            s=s.replace('CM',' ')
            temp+=900
            
        listing=list(s)
        
        for x in listing:
            if x=='I':
                temp+=1
            elif x=='V':
                temp+=5
            elif x=='X':
                temp+=10
            elif x=='L':
                temp+=50
            elif x=='C':
                temp+=100
            elif x=='D':
                temp+=500
            elif x=='M':
                temp+=1000
        
        return temp
            
        
