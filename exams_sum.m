%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/gbell/gbell'); % 79.97 roundla 95.87 oldu
fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/gbell/gbell2'); % 90.64
%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/gauss_lin/gaus_linear'); % 75.42   91.03 oldu roundla
%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/gauss_lin/gaus_linear2'); %91.03
%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/trapezoid/trapezoid');   % 91.03 round tesir etmedi
%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/trapezoid/trapezoid2');  % 91.07
%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy//gaussian/gaussian');  % 79.45 round 88.12e cıxardı
%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/trimf/trimf');  % 64.56  % 88.28e cıxdı round sayesinde
%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/gauss_lin/yeni_gaus_lin'); % 85 %round sayesinde 97.73e cıxdı
%fis=readfis('C:/Users/Ahmad.Ramazanli/Desktop/iş/Ahmad Ramazanli-Fuzzy Logic Documents/with-fuzzy/gauss_lin/yeni_gaus_lin2');  % 97.73

t=xlsread('C:/Users/Ahmad.Ramazanli/Desktop/iş/grades.xlsx','Sheet2');
%raw=height(t)
%column=width(t)

%input=t;
output=evalfis(fis,t);
%options = evalfisOptions('NumSamplePoints',50);
%output = evalfis(fis,[95 95 95 95],options);
t=[t,output];
fuzzy_results="";

for i=1:height(t)
    if round(t(i,5))>= 85
       s="A";
    elseif round(t(i,5))<85 && round(t(i,5))>=65
       s="B";
    elseif round(t(i,5))<65 && round(t(i,5))>= 45
       s="C";
    elseif round(t(i,5))<45 && round(t(i,5))>= 25
       s="D";
    elseif round(t(i,5))<25
       s="E";
    end
    fuzzy_results=[fuzzy_results;s];
end
fuzzy_results=fuzzy_results(2:10001);

[~,z]=xlsread('C:/Users/Ahmad.Ramazanli/Desktop/iş/grades.xlsx','Sheet1','A1:AE128');



real=[z(2:126,1:5);z(2:126,7:11);z(2:126,13:17);z(2:126,19:23);z(2:126,25:29)];
a=1;
index=1;
real_results="";
index1=[];
for i=1:height(t)
    for j=1:4
        if t(i,j)>= 85
           e="A";
           a=1;
        elseif t(i,j)<85 && t(i,j)>=65
           e="B";
           a=2;
        elseif t(i,j)<65 && t(i,j)>= 45
           e="C";
           a=3;
        elseif t(i,j)<45 && t(i,j)>= 25
           e="D";
           a=4;
        elseif t(i,j)<25
           e="E";
           a=5;
        end


        if j==1
            index=1+125*(a-1);
        elseif j==2
            index=index+25*(a-1);
        elseif j==3
            index=index+5*(a-1);
        elseif j==4
            index=index+a-1;
        end
        
        
    end
    
    index1= [index1;index];
    %index qarışır ciddi problem var
    real_results=[real_results;real(index,5)];

    
end  

real_results=real_results(2:10001);
fuzzy_vs_real=["Hard","M2","M1","Easy","Fuzzy Numeric","Fuzzy Letter Grade","EXPECTED Grade";t,fuzzy_results,real_results];


fuzzy_vs_real=[fuzzy_vs_real(1,1:7),"Similar T/F";fuzzy_vs_real(2:10001,1:7), fuzzy_vs_real(2:10001,6)==fuzzy_vs_real(2:10001,7)];

b=0;

for i=2:10001
    if fuzzy_vs_real(i,8)=="true"
        b=b+1;
    end
end
c=10000-b;
correctness=round(b/10000*100,4)