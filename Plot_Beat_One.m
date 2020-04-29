
function y = Plot_Beat_One(app,x,~,r)
%This function calculates the value of Asin(x-r) at a certain position
%and returns the y coordinate
     if app.Sine1Switch.Value == "On"
            valueKnob1 = app.Sine1Knob.Value;
            app.LampSine1.Color = "green";
            y = valueKnob1*sin(x - r);
            plot(app.Sine1,x,y)
        else
            y = 0;
            app.LampSine1.Color = "red";
     end  

end

