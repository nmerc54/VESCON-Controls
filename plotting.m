%% Display Results
time_factor = 60;
time_label = 'Minutes';

%Body Rates vs. Torque
% figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
%     subplot(2, 1, 1)
%         plot(t, w_B(1,:).*r2d, t, w_B(2,:).*r2d, t, w_B(3,:).*r2d), grid on,
%         legend({'\omega_{x}', '\omega_{y}', '\omega_{z}'}),
%         title('Body-Rates'), xlabel('Seconds'), ylabel('degrees/sec');
%     subplot(2,1,2)
%         plot(t, T_B(1,:), t, T_B(2,:), t, T_B(3,:)), grid on,
%         legend({'x', 'y', 'z'}), %axis([0 orbitPeriod -0.01 0.01]),
%         title('Torques');
    
%Euler Angles vs. Torque
figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    subplot(2,1,1)
        plot(t./time_factor, Euler(1,:).*r2d, t./time_factor, Euler(2,:).*r2d, t./time_factor, Euler(3,:).*r2d), grid on,
        legend({'\Phi (Roll)', '\Theta (Pitch)', '\Psi (Yaw)'}),
        title('Euler Angels'), xlabel(time_label), ylabel('degrees');    
    subplot(2,1,2)
        plot(t./time_factor, T_B(1,:), t./time_factor, T_B(2,:), t./time_factor, T_B(3,:)), grid on,
        legend({'x', 'y', 'z'}), %axis([0 orbitPeriod -0.01 0.01]),
        title('Torques');

% Quaternion Components        
figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    subplot(2,1,1)
        plot(t./time_factor, euler_axis(1,:), t./time_factor, euler_axis(2,:), t./time_factor, euler_axis(3,:)), grid on,
        legend({'e_x', 'e_y', 'e_z'}),
        title('Euler Axis'), xlabel(time_label);    
    subplot(2,1,2)
        plot(t./time_factor, axis_angle.*r2d), grid on,
        xlabel(time_factor), ylabel('Degrees'), %axis([0 orbitPeriod -180 180]),
        title('Euler Axis Rotation');

figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    plot(t./time_factor, q_BtoI(1,:), t./time_factor, q_BtoI(2,:), t./time_factor, q_BtoI(3,:), t./time_factor, q_BtoI(4, :)), grid on,
    legend({'q_1', 'q_2', 'q_3', 'q_4'}),
    title('Quaternions'), xlabel(time_label);    


% Body Rates
% figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
%     subplot(3, 1, 1)
%         plot(t, w_B(1, :).*r2d), title('Body - X rotation'), grid on,
%         xlabel('Orbits'), ylabel('Degree/s'),
%         %axis([0 orbitPeriod -180 180]);
%     subplot(3, 1, 2)
%         plot(t, w_B(2, :).*r2d), title('Body - Y rotation'), grid on,
%         xlabel('Orbits'), ylabel('Degree/s'),
%         %axis([0 orbitPeriod -180 180]);
%     subplot(3, 1, 3)
%         plot(t, w_B(3, :).*r2d), title('Body - Z rotation'), grid on,
%         xlabel('Orbits'), ylabel('Degree/s'),
%         %axis([0 orbitPeriod -180 180]);
 
% Euler Angles
% figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
%     subplot(3, 1, 1)
%         plot(t, Euler(1, :).*r2d), title('\Phi (Roll)'), grid on,
%         xlabel('Orbits'), ylabel('Degrees'),
%         %axis([0 orbitPeriod -180 180]);
%     subplot(3, 1, 2)
%         plot(t, Euler(2, :).*r2d), title('\Theta (Pitch)'), grid on,
%         xlabel('Orbits'), ylabel('Degrees'),
%         %axis([0 orbitPeriod -180 180]);
%     subplot(3, 1, 3)
%         plot(t, Euler(3, :).*r2d), title('\Psi (Yaw)'), grid on,
%         xlabel('Orbits'), ylabel('Degrees'),
%         %axis([0 orbitPeriod -180 180]);    
    
 % Torques
%  figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
%     subplot(3, 1, 1)
%         plot(t, T_B(1, :)), title('Body x Torque'), grid on,
%         xlabel('Orbits'), ylabel('Newton-Meters'),
%         %axis([0 orbitPeriod -180 180]);
%     subplot(3, 1, 2)
%         plot(t, T_B(2, :)), title('Body y Torque'), grid on,
%         xlabel('Orbits'), ylabel('Newton-Meters'),
%         %axis([0 orbitPeriod -180 180]);
%     subplot(3, 1, 3)
%         plot(t, T_B(3, :)), title('Body z Torque'), grid on,
%         xlabel('Orbits'), ylabel('Newton-Meters'),
%         %axis([0 orbitPeriod -180 180]);  
    


