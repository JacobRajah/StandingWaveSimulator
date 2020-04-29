function Plot_Result(app,x,y,z)
%This function calculates the resulting interference between the 
%two sin waves
    if app.ResultantSwitch.Value == "On"
        plot(app.ResultantWave,x,z+y)
        app.LampResultant.Color = "green";
    else
        app.LampResultant.Color = "red";
    end
end


