function all_strat

%import data 
filename='Smith et al. TBI PAL Data.xlsx' %change to your filename
sheet1 = 'Cor' %change sheetname to whatever excel sheet houses your correct trial information
sheet2 = 'Type' %change sheetname to whatever excel sheet houses your trial type information

ct= readmatrix(filename,'Sheet', sheet1); 
tt= readmatrix(filename,'Sheet', sheet2); 
for i=1:length(ct)
        x=isnan(ct(i,5:end));
        x= 90-sum(x); %number of trials completed
trialcount(i)= x;
end

trialcount=trialcount'
% delete a day if animal completed fewer than $ trials 
% for i=length(ct):-1:1
%     x=isnan(ct(i,$))
%     if x==1
%         ct(i,:)=[];
%         tt(i,:)=[];
%     end
% end

%%
x=length(ct); %how many rows the sheet currently has

%initialize counters
count=0;
potential_ws=0; %initialize win-stay total
actual_ws=0; %actual win-stay

trialtype=[1 2 3 4 5 6]; %trial type
comptrial=[4 6 1 2 ; %complimentary trials for each trial type,
    4 6 1 2 ; %column 1,2 = incorrect choice as win-stay
    2 5 3 4 ; %column 3,4 = correct choice as win-stay
    2 5 3 4 ;
    1 3 5 6 ;
    1 3 5 6];

for i=1:6
    for row=1:x
        correctrow=ct(row,:);
        typerow=tt(row,:);
        for column=5:93
            if typerow(column)==trialtype(i) && correctrow(column)==1
                for j=1:2 %trials where incorrect complimentary trial means win-stay
                    if typerow(column+1)==comptrial(i,j)
                        potential_ws=potential_ws+1;
                        if correctrow(column+1)==0 %incorrect choice, same object, win-stay strategy
                            actual_ws=actual_ws+1;
                        elseif correctrow(column+1)==1 %correct choice, diff object (by default)
                            actual_ws=actual_ws;
                        end
                    else
                        potential_ws=potential_ws;
                        
                    end
              
                end
                for j=3:4 %trials where correct complimentary trials means win-stay (duplicate trials)
                    if typerow(column+1)==comptrial(i,j)
                         potential_ws=potential_ws+1;
                        if correctrow(column+1)==0 %incorrect choice, diff object,
                            actual_ws=actual_ws;
                        elseif correctrow(column+1)==1 %correct choice, same object, win-stay strategy
                            actual_ws=actual_ws+1;
                        end
                    else
                        potential_ws=potential_ws;
                        
                    end
                end
            end
            
        end
           potential_win_stay(row, trialtype(i))=potential_ws;
                 actual_win_stay(row, trialtype(i))=actual_ws;
        potential_ws=0;
        actual_ws=0;
    end
end

flower_actual= (actual_win_stay(:,1)+ actual_win_stay(:,2));
flower_potential= (potential_win_stay(:,1) + potential_win_stay(:,2));

plane_actual= (actual_win_stay(:,3)+ actual_win_stay(:,4));
plane_potential= (potential_win_stay(:,3) + potential_win_stay(:,4));

spider_actual= (actual_win_stay(:,5)+ actual_win_stay(:,6));
spider_potential= (potential_win_stay(:,5) + potential_win_stay(:,6));

flower_ws=flower_actual ./ sum(potential_win_stay,2);
plane_ws= plane_actual ./ sum(potential_win_stay,2);
spider_ws=spider_actual ./ sum(potential_win_stay,2);
total_obj_ws=sum(actual_win_stay,2) ./ sum(potential_win_stay,2);

%convert NaN to 0 (error from 0 / 0)
flower_ws(isnan(flower_ws)) = 0;
plane_ws(isnan(plane_ws)) = 0;
spider_ws(isnan(spider_ws)) = 0;
total_obj_ws(isnan(total_obj_ws)) = 0;

%%


x=length(ct); %how many rows the sheet currently has

%initialize counters
count=0; 
potential_ws=0; %initialize win-stay total
actual_ws=0; %actual win-stay

trialtype=[1 2 3 4 5 6]; %trial type
comptrial=[3 5 1 2 ; %complimentary trials for each trial type, 
           3 5 1 2 ; %column 1,2 = incorrect choice as win-stay
           1 6 3 4 ; %column 3,4 = correct choice as win-stay
           1 6 3 4 ; 
           2 4 5 6 ; 
           2 4 5 6]; 
    
for i=1:6
    for row=1:x
        correctrow=ct(row,:);
        typerow=tt(row,:);
        for column=5:93
            if typerow(column)==trialtype(i) && correctrow(column)==1
                for j=1:2 %trials where incorrect complimentary trial means win-stay
                    if typerow(column+1)==comptrial(i,j)
                        potential_ws=potential_ws+1;
                        if correctrow(column+1)==0 %incorrect choice, win-stay strategy
                            actual_ws=actual_ws+1;
                        elseif correctrow(column+1)==1 %correct choice, 
                            actual_ws=actual_ws;
                        end
                    else
                         potential_ws=potential_ws;
                        
                    end
                end
                for j=3:4 %trials where correct complimentary trials means win-stay (duplicate trials)
                    if typerow(column+1)==comptrial(i,j)
                        potential_ws=potential_ws+1;
                        if correctrow(column+1)==0 %incorrect choice, 
                            actual_ws=actual_ws;
                        elseif correctrow(column+1)==1 %correct choice, win-stay strategy
                            actual_ws=actual_ws+1;
                        end
                    else
                        potential_ws=potential_ws;
                        
                    end
                end
            end
        end
        potential_win_stay(row, trialtype(i))=potential_ws;
        potential_ws=0;
        actual_win_stay(row, trialtype(i))=actual_ws;
        actual_ws=0;
    end
end

left_actual= (actual_win_stay(:,1)+ actual_win_stay(:,2))
left_potential= (potential_win_stay(:,1) + potential_win_stay(:,2))

center_actual= (actual_win_stay(:,3)+ actual_win_stay(:,4))
center_potential= (potential_win_stay(:,3) + potential_win_stay(:,4))

right_actual= (actual_win_stay(:,5)+ actual_win_stay(:,6))
right_potential= (potential_win_stay(:,5) + potential_win_stay(:,6))

left_ws=left_actual ./ sum(potential_win_stay,2)
center_ws=center_actual ./ sum(potential_win_stay,2)
right_ws=right_actual ./ sum(potential_win_stay,2)
total_pl_ws=sum(actual_win_stay,2) ./ sum(potential_win_stay,2)

%convert NaN to 0 (error from 0 / 0)
left_ws(isnan(left_ws)) = 0
center_ws(isnan(center_ws)) = 0
right_ws(isnan(right_ws)) = 0
total_pl_ws(isnan(total_pl_ws)) = 0
%%
x=length(ct); %how many rows the sheet currently has

%initialize counters
count=0; 
potential_ls=0; %initialize win-stay total
actual_ls=0; %actual win-stay

trialtype=[1 2 3 4 5 6]; %trial type
comptrial=[5 6 1 3 ; %complimentary trials for each trial type, 
           3 4 2 5 ; %column 1,2 = incorrect choice as lose_shift
           5 6 1 3 ; %column 3,4 = correct choice as lose_shift
           1 2 4 6;
           3 4 2 5; 
           1 2 4 6]; 
    
for i=1:6
    for row=1:x
        correctrow=ct(row,:);
        typerow=tt(row,:);
        for column=5:93
            if typerow(column)==trialtype(i) && correctrow(column)==1
                for j=1:2 %trials where incorrect complimentary trial means lose-shift
                    if typerow(column+1)==comptrial(i,j)
                        potential_ls=potential_ls+1;
                        if correctrow(column+1)==0 %incorrect choice, lose-shift strategy
                            actual_ls=actual_ls+1;
                        elseif correctrow(column+1)==1 %correct choice
                            actual_ls=actual_ls;
                        end
                    else
                        potential_ls=potential_ls;
                        
                    end
                end
                for j=3:4 %trials where correct complimentary trials means lose-shift (duplicate trials)
                    if typerow(column+1)==comptrial(i,j)
                        potential_ls=potential_ls+1;
                        if correctrow(column+1)==0 %incorrect choice
                            actual_ls=actual_ls;
                        elseif correctrow(column+1)==1 %correct choice, lose-shift
                        end
                    else 
                        potential_ls=potential_ls;
                    end
                end
            end
        end
        potential_lose_shift(row, trialtype(i))=potential_ls;
        potential_ls=0;
        actual_lose_shift(row, trialtype(i))=actual_ls;
        actual_ls=0;
    end
end


flower_actual= (actual_lose_shift(:,4)+ actual_lose_shift(:,6))
flower_potential= (potential_lose_shift(:,4) + potential_lose_shift(:,6))

plane_actual= (actual_lose_shift(:,2)+ actual_lose_shift(:,5))
plane_potential= (potential_lose_shift(:,2) + potential_lose_shift(:,5))

spider_actual= (actual_lose_shift(:,1)+ actual_lose_shift(:,3))
spider_potential= (potential_lose_shift(:,1) + potential_lose_shift(:,3))

flower_ls=flower_actual ./ sum(potential_lose_shift,2)
plane_ls=plane_actual ./ sum(potential_lose_shift,2)
spider_ls=spider_actual ./ sum(potential_lose_shift,2)
total_obj_ls=sum(actual_lose_shift,2) ./ sum(potential_lose_shift,2)

%convert NaN to 0 (error from 0 / 0)
flower_ls(isnan(flower_ls)) = 0
plane_ls(isnan(plane_ls)) = 0
spider_ls(isnan(spider_ls)) = 0
total_obj_ls(isnan(total_obj_ls)) = 0
%%
x=length(ct); %how many rows the sheet currently has

%initialize counters
count=0; 
potential_ls=0; %initialize lose-shift total
actual_ls=0; %actual lose-shift

trialtype=[1 2 3 4 5 6]; %trial type
comptrial=[3 4 1 6 ; %complimentary trials for each trial type, 
           5 6 2 4 ; %column 1,2 = incorrect choice as lose-shift
           1 2 3 5; %column 3,4 = correct choice as lose-shift
           5 6 2 4;
           1 2 3 5; 
           3 4 1 6]; 
    
for i=1:6
    for row=1:x
        correctrow=ct(row,:);
        typerow=tt(row,:);
        for column=5:93
            if typerow(column)==trialtype(i) && correctrow(column)==1
                for j=1:2 %trials where incorrect complimentary trial means lose-shift
                    if typerow(column+1)==comptrial(i,j)
                        potential_ls=potential_ls+1;
                        if correctrow(column+1)==0 %incorrect choice, lose-shift strategy
                            actual_ls=actual_ls+1;
                        elseif correctrow(column+1)==1 %correct choice
                            actual_ls=actual_ls;
                        end
                    else
                        potential_ls=potential_ls;
                        
                    end
                end
                for j=3:4 %trials where correct complimentary trials means lose-shift (duplicate trials)
                    if typerow(column+1)==comptrial(i,j)
                        potential_ls=potential_ls+1;
                        if correctrow(column+1)==0 %incorrect choice
                            actual_ls=actual_ls;
                        elseif correctrow(column+1)==1 %correct choice, lose-shift
                            actual_ls=actual_ls+1;
                        end
                    else
                        potential_ls=potential_ls;
                        
                    end
                end
            end
        end
        potential_lose_shift(row, trialtype(i))=potential_ls;
        potential_ls=0;
        actual_lose_shift(row, trialtype(i))=actual_ls;
        actual_ls=0;
    end
end

left_actual= (actual_lose_shift(:,3)+ actual_lose_shift(:,5))
left_potential= (potential_lose_shift(:,3) + potential_lose_shift(:,5))

center_actual= (actual_lose_shift(:,1)+ actual_lose_shift(:,6))
center_potential= (potential_lose_shift(:,1) + potential_lose_shift(:,6))

right_actual= (actual_lose_shift(:,2)+ actual_lose_shift(:,4))
right_potential= (potential_lose_shift(:,2) + potential_lose_shift(:,4))


left_ls = left_actual ./ (sum(potential_lose_shift,2))
center_ls =center_actual ./ (sum(potential_lose_shift,2))
right_ls = right_actual ./ (sum(potential_lose_shift,2))
total_pl_ls= sum(actual_lose_shift,2) ./ sum(potential_lose_shift,2)

%convert NaN to 0 (error from 0 / 0)
left_ls(isnan(left_ls)) = 0
center_ls(isnan(center_ls)) = 0
right_ls(isnan(right_ls)) = 0
total_pl_ls(isnan(total_pl_ls)) = 0
%%
my_data=[ct(:,1) total_obj_ws total_pl_ws total_obj_ls total_pl_ls trialcount]

str1='Animal ID'
 str2='Total Stimulus Win Stay'
 str3='Total Location Win Stay'
 str4='Total Stimulus Lose Shift'
 str5='Total Location Lose Shift'
 str6='Trial Count'

F =[{str1} {str2} {str3} {str4} {str5} {str6}]
 filename='TBI_Test2.xlsx' %rename to whatever you want
    t=table(my_data)
    writecell(F,filename,'Range','A1')
    writetable(t,filename,'Range','A2')
end
