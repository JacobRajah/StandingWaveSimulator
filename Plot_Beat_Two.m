function z = Plot_Beat_Two(app,x,r,~)
%This function calculates the value of Asin(-x-r) at a certain position
%and returns the y coordinate
    if app.Sine2Switch.Value == "On"
        app.LampSine2.Color = "green";
        valueKnob2 = app.Sine2Knob.Value;
        z = valueKnob2*sin(-x - r);
        plot(app.Sine2,x,z)
    else
        z = 0;
        app.LampSine2.Color = "red";
    end 
end


