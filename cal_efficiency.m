% Script to load data.

%% 



%load data
cd /home/despo/kaihwang/Rest
%load Data_500.mat
DATASET{1}='Data.mat';
DATASET{2}='Data_500.mat';
DATASET{3}='Data_100.mat';

%threshold
T = 0.05:0.005:0.15;


for c = 1:3
    load(DATASET{c});
    
    n=1;
    for s = Th_Sub
        i=1;
        for th = T
            M = squeeze(M_th(:,:,n));
            [E] = efficiency_bin(threshold_proportional(M,th));
            Efficiency_tha(c,n,i) = E;
            
            M = squeeze(M_th_R(:,:,n));
            [E] = efficiency_bin(threshold_proportional(M,th));
            Efficiency_tha_R(c,n,i) = E;
            
            M = squeeze(M_th_L(:,:,n));
            [E] = efficiency_bin(threshold_proportional(M,th));
            Efficiency_tha_L(c,n,i) = E;

            i=i+1;
        end
        n=n+1;
    end
    
    n=1;
    for s = BG_Sub
        i=1;
        for th = T
            M = squeeze(M_BG(:,:,n));
            [E] = efficiency_bin(threshold_proportional(M,th));
            Efficiency_BG(c,n,i) = E;
            
            M = squeeze(M_BG_R(:,:,n));
            [E] = efficiency_bin(threshold_proportional(M,th));
            Efficiency_BG_R(c,n,i) = E;
            
            M = squeeze(M_BG_L(:,:,n));
            [E] = efficiency_bin(threshold_proportional(M,th));
            Efficiency_BG_L(c,n,i) = E;

            i=i+1;
        end
        n=n+1;
    end
    
    n=1;
    for s = C_Sub
        i=1;
        for th = T
            
            M = squeeze(M_c(:,:,n));
            [E] = efficiency_wei(threshold_proportional(M,th));
            Efficiency_Control(c,n,i) = E;
            
            M = squeeze(M_c_R(:,:,n));
            [E] = efficiency_wei(threshold_proportional(M,th));
            Efficiency_Control_R(c,n,i) = E;
            
            M = squeeze(M_c_L(:,:,n));
            [E] = efficiency_wei(threshold_proportional(M,th));
            Efficiency_Control_L(c,n,i) = E;

            i=i+1;
        end
        n=n+1;
    end
    
end

clear c n i th s E M
save efficiency_wei.mat





