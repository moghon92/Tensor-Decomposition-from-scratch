%%% Video
vidObj = VideoWriter('heat_T3.noise.avi');
vidObj.FrameRate = 10; % select frameRate
open(vidObj);
hFig = figure;
for t = 1:10    
    imagesc(double(T2(:,:,t)))
    colormap('gray')
    set(gca,'XTick',[]) % Remove the ticks in the x axis!
    set(gca,'YTick',[]) % Remove the ticks in the y axis
    set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure
    colormap hot;
    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);
end
close(vidObj);

%% %%% CP Decomposition
K = ['Tensor1'; 'Tensor2'; 'Tensor3'];
for t = 1:3
    if t==1
        T = T1;
    elseif t==2
        T = T2;
    else
        T = T3;
    end

    X1 = tenmat(T,1);
    err = zeros(10,1);
    for i = 1:10
        P = cp_als(T,i);
        P1 = tenmat(P,1);
        dif = tensor(X1-P1);
        err(i) = innerprod(dif,dif);
    end

    AIC =  2*err + (2*[1:10])';
    [min_,wmin] = min(AIC);
    
    figure(1)
    subplot(1,3,t);
    plot(AIC)
    xlabel('R')
    ylabel('AIC')
    title(K(t,1:7), ["MIN AIC=",min_, "at R=", wmin])
    
    
    P = cp_als(T,1);
    
    figure(2)
    subplot(1,3,t);
    plot(P.U{3})
    xlabel('time')
    title(K(t,1:7))
    
    figure(3)
    XY = kron(P.U{1}(:,1),P.U{2}(:,1)')*P.lambda(1);
    ScaledXY = XY*100;
    subplot(1,3,t);
    image(ScaledXY);
    xlabel('x')
    ylabel('y')
    colormap hot
    title([K(t,1:7), "Rank1 decmp"])
end


%% %%% Tucker Decomposition
K = ['Tensor1'; 'Tensor2'; 'Tensor3'];
n = 0;
for t = 1:3
    if t==1
        T = T1;
    elseif t==2
        T = T2;
    else
        T = T3;
    end

    %decomposition
    X1 = tenmat(T,1);
    err = zeros(4,4,4);
    AIC_t = zeros(4,4,4);
  
    for i = 1:4
        for j = 1:4
            for k = 1:4
                Tucker = tucker_als(T,[i,j,k]);
                Tucker1 = tenmat(Tucker,1);
                dif = tensor(X1-Tucker1);
                err(i,j,k) = innerprod(dif,dif);
                AIC_t(i,j,k) = 2*err(i,j,k) + 2*(i+j+k);
            end
        end  
    end
    %pcshow(AIC_t); 
    %min AIC and index of min AIC
    [v,loc] = min(AIC_t(:));
    [ii,jj,kk] = ind2sub(size(AIC_t),loc);
    figure(3)
    subplot(1,3,t);
    plot(AIC_t(:,jj,kk))
     xlabel('R')
    ylabel('AIC')
    title(K(t,1:7), ["MIN AIC=",v, "at R=[3,3,3]"])
    
    Tucker = tucker_als(T,[3,3,3]);
    XY1 = kron(Tucker.U{1}(:,1),Tucker.U{2}(:,1)');
    XY2 = kron(Tucker.U{1}(:,2),Tucker.U{2}(:,2)');
    XY3 = kron(Tucker.U{1}(:,3),Tucker.U{2}(:,3)');

    n=n+1;
    figure(4);
    subplot(3,3,n);
    image(XY1*1000);
    colormap hot
    xlabel('x')
    ylabel('y')
    title([K(t,1:7), "1st spacial"])
    
    n=n+1;
    subplot(3,3,n);
    image(XY2*1000);
    colormap hot
    xlabel('x')
    ylabel('y')
    title([K(t,1:7), "2nd spacial"])
    
    n=n+1;
    subplot(3,3,n);
    image(XY3*1000);
    colormap hot
    xlabel('x')
    ylabel('y')
    title([K(t,1:7), "3rd spacial"])

    figure(5)
    subplot(1,3,t);
    plot(Tucker.U{3})
    xlabel('time')
    legend('1','2','3')
    title(K(t,1:7))

end
