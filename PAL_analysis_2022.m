function [bias] = PAL_analysis_2020

%This script will output excel sheets from touchscreen data collected from
%Layfette touchscreen systems and Abett software to run Paired Associates
%Learning, a cognitive test within the CANTAB test battery. 

%The excel sheets contains the following outputs related to the animals 'bias' - 
% The bias is a tendency to perseverate on an object or place choice without correctly performing the associations  
% 'error rate'
% 'percent correct'
% 'left place'
% 'middle place'
% 'right place'
% 'total place bias'
% 'left object'
% 'middle object'
% 'right object'
% 'total object bias'
% 'trial count'

%import data
filename='TBI_Post.xlsx' %change to your filename
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

% Uncomment the section below if you want to delete a day if animal completed fewer than $ trials

% for i=length(ct):-1:1
%     x=isnan(ct(i,$))
%     if x==1
%         ct(i,:)=[];
%         tt(i,:)=[];
%     end
% end

correct=0; %initilaize counter
x=length(ct); %how many rows the sheet currently has

%For loop - go across the the rows (each row is one animal on one testing day across 90 trials) and then move to the next row  
for i=1:6
    for row=1:x
        correctrow=ct(row,:);
        for column=5:94 % depending on how you get your excel sheet off of the touchscreens, your correct trial counting for each animal may start on a different column then mine (5). 
            % Make sure you input the column numbers you intend to analyze.
            if correctrow(column)==1
                correct=correct+1;
            elseif correctrow(column)==0
                correct=correct;
            end
        end
        correct_m(row,1)=correct;
        correct=0; %re-initialize counter
    end
end
percent_correct=(correct_m./(trialcount))*100
error_rate=(trialcount-correct_m)./trialcount
x=length(ct); %how many rows the sheet currently has

%initialize counters
true_left=0;
true_middle=0;
true_right=0;
false_left=0;
false_middle=0;
false_right=0;
true_flower=0;
true_plane=0;
true_spider=0;
false_flower=0;
false_plane=0;
false_spider=0;


% I am learning how to code...please excuse the massive series of if statements...if you want to
% email me a simpler solution please feel free sammsmith14@gmail.com
for row=1:x
    correctrow=ct(row,:);
    typerow=tt(row,:);
possible(row,1)=sum(tt(row,:)==1);
possible(row,2)=sum(tt(row,:)==2);
possible(row,3)=sum(tt(row,:)==3);
possible(row,4)=sum(tt(row,:)==4);
possible(row,5)=sum(tt(row,:)==5);
possible(row,6)=sum(tt(row,:)==6);
    for column=5:94
        if (typerow(column)==1 || typerow(column)==2) && correctrow(column)==1
            true_left=true_left+1;
        else
            true_left=true_left;
        end
        
        if (typerow(column)==3|| typerow(column)==4) && correctrow(column)==1
            true_middle=true_middle+1;
        else
            true_middle=true_middle;
        end
        
        if (typerow(column)==5 || typerow(column)==6) && correctrow(column)==1
            true_right=true_right+1;
        else
            true_right=true_right;
        end
        if (typerow(column)==3 || typerow(column)==5) && correctrow(column)==0
            false_left=false_left+1;
        else
            false_left=false_left;
        end
        
        if (typerow(column)==1|| typerow(column)==6) && correctrow(column)==0
            false_middle=false_middle+1;
        else
            false_middle=false_middle;
        end
        
        if (typerow(column)==2 || typerow(column)==4) && correctrow(column)==0
            false_right=false_right+1;
        else
            false_right=false_right;
        end
    end
    true_place(row,1)=true_left;
    true_place(row,2)=true_middle;
    true_place(row,3)=true_right;
    false_place(row,1)=false_left;
    false_place(row,2)=false_middle;
    false_place(row,3)=false_right;

    true_left=0;
    true_middle=0;
    true_right=0;
    false_left=0;
    false_middle=0;
    false_right=0;
  
end
   
    
for row=1:x
    correctrow=ct(row,:);
    typerow=tt(row,:);
    for column=5:94
        if (typerow(column)==1 || typerow(column)==2) && correctrow(column)==1
            true_flower=true_flower+1;
        else
            true_flower=true_flower;
        end
        
        if (typerow(column)==3|| typerow(column)==4) && correctrow(column)==1
            true_plane=true_plane+1;
        else
            true_plane=true_plane;
        end
        
        if (typerow(column)==5 || typerow(column)==6) && correctrow(column)==1
            true_spider=true_spider+1;
        else
            true_spider=true_spider;
        end
        if (typerow(column)==4 || typerow(column)==6) && correctrow(column)==0
            false_flower=false_flower+1;
        else
            false_flower=false_flower;
        end
        
        if (typerow(column)==2|| typerow(column)==5) && correctrow(column)==0
            false_plane=false_plane+1;
        else
            false_plane=false_plane;
        end
        
        if (typerow(column)==1 || typerow(column)==3) && correctrow(column)==0
            false_spider=false_spider+1;
        else
            false_spider=false_spider;
        end
    end
    true_object(row,1)=true_spider;
    true_object(row,2)=true_plane;
    true_object(row,3)=true_spider;
    false_object(row,1)=false_flower;
    false_object(row,2)=false_plane;
    false_object(row,3)=false_spider;

    true_spider=0;
    true_plane=0;
    true_spider=0;
    false_flower=0;
    false_plane=0;
    false_spider=0;
  
end

    format SHORTG
possible_place(:,1)=possible(:,1)+possible(:,2) %1,2 possible correct left
possible_place(:,2)=possible(:,3)+possible(:,4) %3,4 possible correct middle
possible_place(:,3)=possible(:,5)+possible(:,6) %5,6 possible correct right
possible_object(:,1)=possible(:,1)+possible(:,2) %1,2 possible correct flower
possible_object(:,2)=possible(:,3)+possible(:,4) %3,4 possible correct plane
possible_object(:,3)=possible(:,5)+possible(:,6) %5,6 possible correct spider
place_bias(:,1:3)=abs(((true_place+false_place)-possible_place)./possible_place); %number selections-number possible correct/number possible correct
place_bias(:,4)=place_bias(:,1)+place_bias(:,2)+place_bias(:,3) %overall bias (left+middle+right)
[~,~,X] = unique(place_bias(:,1));

object_bias(:,1:3)=abs(((true_object+false_object)-possible_object)./possible_object); %number selections-number possible correct/number possible correct
object_bias(:,4)=object_bias(:,1)+object_bias(:,2)+object_bias(:,3) %overall bias (flower+plane+spider)
[~,~,X] = unique(ct(:,1));
my_data=[ct(:,1) percent_correct error_rate trialcount place_bias object_bias]

str1='Animal ID'
 str2='Percent Correct'
 str3='Error Rate'
 str4='trial count'
 str5='left place'
 str6='middle place'
 str7='right place'
 str8='total place bias'
 str9='left object'
 str10='middle object'
 str11='right object'
 str12='total object bias'

F =[{str1} {str2} {str3} {str4} {str5} {str6} {str7} {str8} {str9} {str10} {str11} {str12}]
 filename='TBI_Test.xlsx' %rename to whatever you want
    t=table(my_data)
    writecell(F,filename,'Range','A1')
    writetable(t,filename,'Range','A2')
end

