%In this code i will be implementing stop-and-wait protocol

% for sender side
%   1=data received
%   0=data sent


%sender_history=zeros(1,10);
%receiver_history=zeros(1,10);
function [window,row]=create_window(data,Swindow_size)
remainder=fix(length(data)/Swindow_size);
if rem(length(data),Swindow_size)==0
    row=remainder;
    window=zeros(row,Swindow_size);
else
    row=remainder+1;
    window=zeros(row,Swindow_size);
end

%copying values to window matrix
i=1;
for k=1:row
    for j=1:Swindow_size
        if i<=length(data)
            window(k,j)=data(i);
            i=i+1;
        else
            window(k,j)=2;
        end
    end
end
end
data=[1 0 1 1 1 0 1 0 0 1 0];
Swindow_size=4;
[windowData,row_value]=create_window(data,Swindow_size);

sender=zeros(1,length(data));
receiver=zeros(1,length(data));

send=1;
while(true)
    for i=1:row_value

        condi1=randi([0,1]);
        fprintf("Rand=%d\n",condi);
        if condi1==1
            if send<Swindow_size+1&&send>0
                receiver(1,send)=windowData(i,send);
                fprintf("Successfull at position receiver(1,%d)\n",send);
                send=send+1;
            elseif send<=0||send==Swindow_size+1
                send=1;

            end
        else
            fprintf("Transmiting again to position receiver(1,%d)\n",send);
        end
    end
    if windowData(i,send)==2
        break
    end
end


% t=timer;
% t.StartDelay=0;
% t.Period=3;
