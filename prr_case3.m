pipe =4;
recoverFS=10;
ssthresh=5;
maxIteration=10;
    
for i=1:maxIteration
    if(pipe>ssthresh)
        break;
    else
        pipe=pipe-1;
        packet_delivered=i;
        if i==1
            packet_out=0;
        else
            packet_out=packet_out+sndcnt;
        end

        limit=packet_delivered-packet_out;

        sndcnt=min(ssthresh-pipe,limit);
        newPack(i)=packet_out;
        fprintf("Send count =%d\n",sndcnt);
        pack(i)=pipe;
        pipe=pipe+sndcnt;
        cwnd=pipe+sndcnt;
    end
end


figure;
x=1:i;
p2 = plot(x,newPack,'-o', 'LineWidth', 1.5);
title("Packet Reduction Rate for TCP case 3 (pipe <= ssthresh with CRB)");
legend('New packets');
xlabel('No.of ACK','FontSize',12);
ylabel('No.of packets sent','FontSize', 12);
axis([1 11 0 11]);
ticks = [0:11];
set(gca,'XTick',ticks);
set(gca,'YTick',ticks);
saveas(gcf, 'Case 3.jpg', 'jpg');