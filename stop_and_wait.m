%In this code i will be implementing stop-and-wait protocol

% for sender side
%   1=data received
%   0=data sent

function [window]=create_window(data,Swindow_size)
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

function s_a_w()
    data=[1 0 1 1 1 0 1 0 0 1 0];
    Swindow_size=4;
    [windowData]=create_window(data,Swindow_size);
    countSENT=zeros(1,length(data));
    countACK=zeros(1,length(data));
    sender=zeros(1,length(data));
    receiver=zeros(1,length(data));
    send=1;
    i=1;
    j=1;
    while(true)
        condi=randi([0,1]);
        if windowData(i,send)==2
            break
        end
        if condi==1
            if send<=4
                fprintf("Condi=%d\n",condi);
                sender(j)=windowData(i,send);
                fprintf("Successfull sent\n");
                countSENT(1,j)=countSENT(1,j)+1;
                condi1=randi([0,1]);
                if condi1==1
                    receiver(j)=sender(j);
                    fprintf("ACK sent successfully\n");
                    countACK(1,j)=countACK(1,j)+1;
                    send=send+1;
                    j=j+1;
                else
                    fprintf("Condi1=%d\n",condi1);
                    fprintf("Ack failed to receive\nTransmitting again from start to position %d\n",j);
                end
    
            end
        else
            % i=i+1;
            fprintf("Condi=%d\n",condi);
            fprintf("Transmission failed\n");
        end
        if send>4
                send=1;
                i=i+1;
        end
    end
end

