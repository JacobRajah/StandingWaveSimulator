classdef standingwavedemo_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        StandingWaves              matlab.ui.Figure
        Sine1                      matlab.ui.control.UIAxes
        Sine2                      matlab.ui.control.UIAxes
        ResultantWave              matlab.ui.control.UIAxes
        Wave1Label                 matlab.ui.control.Label
        LampSine1                  matlab.ui.control.Lamp
        Sine1Switch                matlab.ui.control.ToggleSwitch
        Sine2Switch                matlab.ui.control.ToggleSwitch
        Wave2Label                 matlab.ui.control.Label
        LampSine2                  matlab.ui.control.Lamp
        STARTSIMButton             matlab.ui.control.StateButton
        ResultantSwitch            matlab.ui.control.ToggleSwitch
        ResultantLabel             matlab.ui.control.Label
        LampResultant              matlab.ui.control.Lamp
        AdjustWave1AmplitudeLabel  matlab.ui.control.Label
        Sine1Knob                  matlab.ui.control.Knob
        AdjustWave2AmplitudeLabel  matlab.ui.control.Label
        Sine2Knob                  matlab.ui.control.Knob
        QUITButton                 matlab.ui.control.Button
        TextArea                   matlab.ui.control.TextArea
    end

    
    methods (Access = private)
        %This function is responsible for animating the three sine graphs
        %the animation will continue until the restart animation button is 
        %pressed
        function check_status(app)
            r = 0;
            x = 0:0.1:10;
            y = 0;
            z = 0;
            while(app.STARTSIMButton.Value == true)
                  
                y = Plot_Beat_One(app,x,y,r);
                z = Plot_Beat_Two(app,x,r,z);
                Plot_Result(app,x,y,z);
                
                pause(0.1);
                r = r + 0.1;
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %Preset the lamp colors
            app.LampSine1.Color = 'red';
            app.LampSine2.Color = 'red';
            app.LampResultant.Color = 'red';
        end

        % Value changed function: STARTSIMButton
        function STARTSIMButtonValueChanged(app, event)
            value = app.STARTSIMButton.Value;
            %Check the value of the start sim button
            if value == true
                app.STARTSIMButton.BackgroundColor = "green";
                app.STARTSIMButton.Text = 'RESTART SIM';
                check_status(app);
            else
                app.STARTSIMButton.BackgroundColor = "red";
                app.STARTSIMButton.Text = 'START SIM';
            end
        end

        % Value changing function: Sine2Knob
        function Sine2KnobValueChanging(app, event)
            changingValue = event.Value;
            valueKnob1 = app.Sine1Knob.Value;
            %Update the y axis limits if the amplitude is changed for the
            %second sin wave
            app.ResultantWave.YLim = [-(changingValue + valueKnob1)  
                (changingValue + valueKnob1)];
            app.Sine2.YLim = [-changingValue changingValue];
        end

        % Value changing function: Sine1Knob
        function Sine1KnobValueChanging(app, event)
            changingValue = event.Value;
            valueKnob2 = app.Sine2Knob.Value;
            %Update the y axis limits for the resultant and sin1 wave based
            %on the change in sin1 amplitude
            app.ResultantWave.YLim = [-(changingValue + valueKnob2)  
                (changingValue + valueKnob2)];
            app.Sine1.YLim = [-changingValue changingValue];
        end

        % Button pushed function: QUITButton
        function QUITButtonPushed(app, event)
            %If user enters quit then call the function below to quit
            %program
            StandingWavesCloseRequest(app,event);
        end

        % Close request function: StandingWaves
        function StandingWavesCloseRequest(app, event)
            app.STARTSIMButton.Value = false;
            delete(app)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create StandingWaves and hide until all components are created
            app.StandingWaves = uifigure('Visible', 'off');
            app.StandingWaves.Position = [100 100 707 596];
            app.StandingWaves.Name = 'UI Figure';
            app.StandingWaves.CloseRequestFcn = createCallbackFcn(app, @StandingWavesCloseRequest, true);

            % Create Sine1
            app.Sine1 = uiaxes(app.StandingWaves);
            title(app.Sine1, 'Sound Wave 1')
            xlabel(app.Sine1, 'Distance')
            ylabel(app.Sine1, 'Amplitude')
            app.Sine1.PlotBoxAspectRatio = [1.92635658914729 1 1];
            app.Sine1.XLim = [0 10];
            app.Sine1.YLim = [-1 1];
            app.Sine1.Position = [11 376 300 185];

            % Create Sine2
            app.Sine2 = uiaxes(app.StandingWaves);
            title(app.Sine2, 'Sound Wave 2')
            xlabel(app.Sine2, 'Distance')
            ylabel(app.Sine2, 'Amplitude')
            app.Sine2.PlotBoxAspectRatio = [1.92635658914729 1 1];
            app.Sine2.XLim = [0 10];
            app.Sine2.YLim = [-1 1];
            app.Sine2.Position = [10 192 300 185];

            % Create ResultantWave
            app.ResultantWave = uiaxes(app.StandingWaves);
            title(app.ResultantWave, 'Resultant Sound Wave Interference')
            xlabel(app.ResultantWave, 'Distance')
            ylabel(app.ResultantWave, 'Amplitude')
            app.ResultantWave.PlotBoxAspectRatio = [1.10207612456747 1 1];
            app.ResultantWave.XLim = [0 10];
            app.ResultantWave.YLim = [-2 2];
            app.ResultantWave.XTick = [0 1 2 3 4 5 6 7 8 9 10];
            app.ResultantWave.Position = [319 204 370 345];

            % Create Wave1Label
            app.Wave1Label = uilabel(app.StandingWaves);
            app.Wave1Label.HorizontalAlignment = 'right';
            app.Wave1Label.Position = [39 20 42 22];
            app.Wave1Label.Text = 'Wave1';

            % Create LampSine1
            app.LampSine1 = uilamp(app.StandingWaves);
            app.LampSine1.Position = [96 20 20 20];

            % Create Sine1Switch
            app.Sine1Switch = uiswitch(app.StandingWaves, 'toggle');
            app.Sine1Switch.Position = [68 80 20 45];

            % Create Sine2Switch
            app.Sine2Switch = uiswitch(app.StandingWaves, 'toggle');
            app.Sine2Switch.Position = [118 79 20 45];

            % Create Wave2Label
            app.Wave2Label = uilabel(app.StandingWaves);
            app.Wave2Label.HorizontalAlignment = 'right';
            app.Wave2Label.Position = [122 20 42 22];
            app.Wave2Label.Text = 'Wave2';

            % Create LampSine2
            app.LampSine2 = uilamp(app.StandingWaves);
            app.LampSine2.Position = [179 20 20 20];

            % Create STARTSIMButton
            app.STARTSIMButton = uibutton(app.StandingWaves, 'state');
            app.STARTSIMButton.ValueChangedFcn = createCallbackFcn(app, @STARTSIMButtonValueChanged, true);
            app.STARTSIMButton.Text = 'START SIM';
            app.STARTSIMButton.BackgroundColor = [1 0 0];
            app.STARTSIMButton.Position = [57 159 112 22];

            % Create ResultantSwitch
            app.ResultantSwitch = uiswitch(app.StandingWaves, 'toggle');
            app.ResultantSwitch.Position = [168 80 20 45];

            % Create ResultantLabel
            app.ResultantLabel = uilabel(app.StandingWaves);
            app.ResultantLabel.HorizontalAlignment = 'right';
            app.ResultantLabel.Position = [210 19 56 22];
            app.ResultantLabel.Text = 'Resultant';

            % Create LampResultant
            app.LampResultant = uilamp(app.StandingWaves);
            app.LampResultant.Position = [281 19 20 20];

            % Create AdjustWave1AmplitudeLabel
            app.AdjustWave1AmplitudeLabel = uilabel(app.StandingWaves);
            app.AdjustWave1AmplitudeLabel.HorizontalAlignment = 'center';
            app.AdjustWave1AmplitudeLabel.Position = [479 25 82 28];
            app.AdjustWave1AmplitudeLabel.Text = {'Adjust Wave 1'; 'Amplitude'};

            % Create Sine1Knob
            app.Sine1Knob = uiknob(app.StandingWaves, 'continuous');
            app.Sine1Knob.Limits = [1 10];
            app.Sine1Knob.ValueChangingFcn = createCallbackFcn(app, @Sine1KnobValueChanging, true);
            app.Sine1Knob.Position = [489 87 60 60];
            app.Sine1Knob.Value = 1;

            % Create AdjustWave2AmplitudeLabel
            app.AdjustWave2AmplitudeLabel = uilabel(app.StandingWaves);
            app.AdjustWave2AmplitudeLabel.HorizontalAlignment = 'center';
            app.AdjustWave2AmplitudeLabel.Position = [592.5 25 82 28];
            app.AdjustWave2AmplitudeLabel.Text = {'Adjust Wave 2'; 'Amplitude'};

            % Create Sine2Knob
            app.Sine2Knob = uiknob(app.StandingWaves, 'continuous');
            app.Sine2Knob.Limits = [1 10];
            app.Sine2Knob.ValueChangingFcn = createCallbackFcn(app, @Sine2KnobValueChanging, true);
            app.Sine2Knob.Position = [603 87 60 60];
            app.Sine2Knob.Value = 1;

            % Create TextArea
            app.TextArea = uitextarea(app.StandingWaves);
            app.TextArea.Position = [225 52 212 95];
            app.TextArea.Value = {'This simulation is intended to demonstrate the interference of two opposite moving sound waves. If the amplitude of the two sound waves are the same then the result produced is a standing wave.'};

            % Create QUITButton
            app.QUITButton = uibutton(app.StandingWaves, 'push');
            app.QUITButton.ButtonPushedFcn = createCallbackFcn(app, @QUITButtonPushed, true);
            app.QUITButton.BackgroundColor = [0 1 0];
            app.QUITButton.Position = [199 159 112 22];
            app.QUITButton.Text = 'QUIT';

            % Show the figure after all components are created
            app.StandingWaves.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = standingwavedemo_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.StandingWaves)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.StandingWaves)
        end
    end
end