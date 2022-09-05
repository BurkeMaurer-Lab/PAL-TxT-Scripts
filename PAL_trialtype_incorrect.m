function [trial_prop] = PAL_trialtype_incorrect
%import data

%This script will output excel sheets from touchscreen data collected from
%Layfette touchscreen systems and Abett software to run Paired Associates
%Learning, a cognitive test within the CANTAB test battery. 

%The excel sheets contains output related to trial accuracy during specific
%trial types. In PAL, there are 6 different trial types psuedorandomly
%presented across 90 trials in a session. Proportions is calculated 
% as total number incorrect / total number completed for each of trial types 1-6. 

filename='Smith et al. 2022 PAL CCI TBI Raw Data.xlsx' %change to your filename
sheet1 = 'Cor' %change sheetname to whatever excel sheet houses your correct trial information
sheet2 = 'Type' %change sheetname to whatever excel sheet houses your trial type information

ct= readmatrix(filename,'Sheet', sheet1); 
tt= readmatrix(filename,'Sheet', sheet2); 
for i=1:length(ct)
    x=isnan(ct(i,5:end));
    x= 90-sum(x); %number of trials completed
    trialcount(i)= x;
end
trialcount=trialcount';

% delete a day if animal completed fewer than $ trials
% for i=length(ct):-1:1
%     x=isnan(ct(i,$))
%     if x==1
%         ct(i,:)=[];
%         tt(i,:)=[];
%     end
% end
x=length(ct); %how many rows the sheet currently has
latency_m=zeros(708,94);
count=0;
   for i=1:6
    for row=1:x
        correctrow=ct(row,:);
        typerow=tt(row,:);
        for column=5:94
            if typerow(column)==i && correctrow(column)== 0
                count=count+1;
            else
                count=count;
            end
        end
        incorrect(row)=count;
        count=0;     
    end
    incorrect_trial_m(:, i+1)=incorrect;
    incorrect=0;

    end
count=0;
    for i=1:6
    for row=1:x
        correctrow=ct(row,:);
        typerow=tt(row,:);
        for column=5:94
            if typerow(column)==i 
                count=count+1;
            else
                count=count;
            end
        end
        total(row)=count;
        count=0;
%         new_m = mean(latency_m');
% new_m=new_m';
% new_latency_m(:,i)=new_m;
    end
    total_trial_m(:, i+1)=total;
    total=0;

    end
    proportion_m=incorrect_trial_m./total_trial_m

proportion_m(:,1)=ct(:,1)

my_data=[proportion_m]

str1='Animal ID'
 str2='Trial Type 1'
 str3='Trial Type 2'
 str4='Trial Type 3'
 str5='Trial Type 4'
 str6='Trial Type 5'
 str7='Trial Type 6'

F =[{str1} {str2} {str3} {str4} {str5} {str6} {str7}]
 filename='TBI_Test1.xlsx' %rename to whatever you want
    t=table(my_data)
    writecell(F,filename,'Range','A1')
    writetable(t,filename,'Range','A2')
end



