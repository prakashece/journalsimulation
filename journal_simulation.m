    % X=[0.0679 0.0388 0.0379 0.0370 0.0363];
% figure
% plot(X)
%
% epoch=[5,10,15,20,25];
% loss=[0.0370 0.0358 0.0352 0.0345 0.0341];
% figure
% plot(epoch,loss)
clear
close all;
R=[];
k=0;
v=7.4;
ebt=704;
i=10;
pf=0.8;
N_mt=1;
P_mt=v*i*pf*N_mt;
P_pmb=P_mt*0.98*0.98;
P_comm=[0.25,0.75,1,3,6];
%lambda=[19,17,15,13,15,17,19,25,27,35,39,41,49,50,55,59,61,63,59,55,47,41,29,25];
%Avg_users=[19,17,15,13,15,17,19,25,27,41,49,50,55,59,61,63,18,19,15,20,15,17,19,20];
%New_lambda for multiple uav
Avg_users=[19,17,15,13,15,17,19,25,27,35,39,41,49,50,55,59,100,120,70,55,47,41,29,25];
%Avg_users=[19,17,15,13,15,17,19,20,20,19,20,50,55,59,61,63,63,19,15,20,15,17,19,20];
A=[2.1221638e-04 2.5413036e-04 2.7879477e-04 2.9135942e-04 2.9993653e-04 3.0323267e-04 3.0562878e-04 3.1642914e-04 3.5220385e-04 3.7777424e-04 3.9172173e-04 3.7035942e-04 3.3670664e-04 3.7516952e-04 4.5056343e-04 4.2197704e-04 5.4765940e-04 1.0678458e-01 1.8495524e-01 2.7207080e-01 2.9767823e-01 2.9705721e-01 4.7433114e-01 6.8588400e-01 9.6416152e-01 1.1519561e+00 1.0790997e+00 9.8172283e-01 7.4976838e-01 6.7425138e-01 5.0106955e-01 3.3776897e-01 2.6803532e-01 1.6563141e-01 3.7964225e-02 5.0761104e-03 1.6599894e-04 0 0 0 0 0 0 0 0 0 0 0 0];
%A=[0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.049295 0.250591 0.525996 0.845807 1.179320 1.518343 1.849457 2.162446 2.45711 2.719675 2.936978 1.992656 2.455906 3.338125 3.372187 3.362476 3.297550 2.296325 3.013926 2.802063 2.363938 1.979031 1.694280 0.954093 1.059333 0.978106 0.450595 0.244678 0.116930 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000];
%A=[0.000000  0.000000  0.000000  0.000000  0.000000  0.000000  0.000000  0.000000 0.000000  0.000000  0.000000  0.023462 0.158045  0.353078 0.674710 0.927726 1.113484 1.544884 1.556656 1.795094 2.275822 1.896518 1.506963 1.524049 2.193810 1.657318 1.81457 1.776918 1.852095 1.747406 1.025281 1.086594 0.694875 1.127469 1.379531 1.164605 0.859024 0.250449 0.135378 0.040613 0.00000  0.000000  0.000000 0.000000 0.000000 0.000000 0.000000 0.000000];
A=A*88;
m=0;
for i=1:2:48
    m=m+1;
    j(m)=i;
end
m=0;
for e=2:2:48
    m=m+1;
    l(m)=e;
end    
for k=1:24
  R(k)=A(j(k))+A(l(k));
end
for i=1:24
    if(Avg_users(i)<=10)
        P_comm_val=P_comm(1);
    elseif(Avg_users(i)>10 && Avg_users(i)<=20)
        P_comm_val=P_comm(2);
    elseif(Avg_users(i)>20 && Avg_users(i)<=30)
         P_comm_val=P_comm(3);
    elseif(Avg_users(i)>30 && Avg_users(i)<=40)
         P_comm_val=P_comm(4);
    elseif(Avg_users(i)>40)
         %P_comm_val=P_comm(5);    
         P_comm_val=P_comm(4);
    end
    if(i>6 && i<22)
P_tot1(i)=P_pmb+ P_comm_val;
%P_tot1(i)=P_pmb+ 6;
    else
P_tot1(i)=41.8+ P_comm_val;
%P_tot1(i)=41.8+ 6;
end
%P_tot2(i)=P_pmb+P_comm(4);
val(i)= P_tot1(i)-R(i);
if(val(i)<1)
    %this one acts as a battery management unit
    val(i)=1;
end
if(i==1)
time1(i)= (ebt/val(i));
ebt_val(i)=ebt-val(i)*1;
else
 time1(i)= (ebt_val(i-1)/val(i));  
ebt_val(i)=ebt_val(i-1)-val(i-1)*1;
end
end
figure
plot(ebt_val)
figure
plot(time1)
time1=time1';
ebt_val=ebt_val';
disp(time1(24))
disp(ebt_val(24))
