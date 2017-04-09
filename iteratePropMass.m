%% ************************************************************************
%  Iterate Prop Mass
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: VESCON
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante  11-10-2016   
%
% N.Mercadante  04-09-2017   This code was re-written for a modified
%                            controls simulation. Note that this is written
%                            assuming that the prop used on each torque
%                            direction is constant. Will need to be
%                            updated.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% *************************************************************************



function [prop_mass_out] = iteratePropMass(prop_mass, md, dt, thruster_choice)
    
    if ~exist('thruster_choice', 'var')
       % Strictly written for old code. Would rather not re-write this
       % function for a simple added parameter.
       prop_mass_out = prop_mass + md*dt; 
        
    else
        % If any thruster fires, + or -, subtract mass flow * time from
        % prop mass. 
        choice = sum(abs(thruster_choice));          
        prop_mass_out = prop_mass + md*dt*choice;
    
    end

end