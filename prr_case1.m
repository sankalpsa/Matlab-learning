pipe =10;
recoverFS=10;
ssthresh=7;
maxIteration=100;
for i=1:maxIteration
    if(pipe<=ssthresh)
        break;
    else
        pipe=pipe-1;
        packet_delivered=i;
        if i==1
            packet_out=0;
        else
            packet_out=packet_out+sndcnt;
        end
        out(i)=packet_out;      %new packets sent
        sndcnt=ceil((packet_delivered.*ssthresh)/recoverFS)-packet_out;
        fprintf("Send count =%d\n",sndcnt);
        pack(i)=pipe;
        pipe=pipe+sndcnt;
        cwnd=pipe+sndcnt;
    end
end


figure;
x=1:i-1;
p2 = plot(x, out, '--', 'LineWidth', 1.5);
title("Packet Reduction Rate for TCP case1(pipe > ssthresh)");
legend('New Packets');
xlabel('No.of ACK','FontSize',12);
ylabel('No.of packets sent','FontSize', 12);
axis([1 11 0 11]);
ticks = [0:11];
set(gca,'XTick',ticks);
set(gca,'YTick',ticks);
saveas(gcf, 'Case 1.jpg', 'jpg');