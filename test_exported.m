classdef test_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        WeightFunctionsUIFigure    matlab.ui.Figure
        UIAxes                     matlab.ui.control.UIAxes
        ErrorEditFieldLabel        matlab.ui.control.Label
        ErrorEditField             matlab.ui.control.NumericEditField
        ExperimentParametersPanel  matlab.ui.container.Panel
        FresnelNumberSliderLabel   matlab.ui.control.Label
        FresnelNumberSlider        matlab.ui.control.Slider
        DeltaSliderLabel           matlab.ui.control.Label
        DeltaSlider                matlab.ui.control.Slider
        ApertureSliderLabel        matlab.ui.control.Label
        ApertureSlider             matlab.ui.control.Slider
        Panel                      matlab.ui.container.Panel
        QratioSliderLabel          matlab.ui.control.Label
        QratioSlider               matlab.ui.control.Slider
        HSliderLabel               matlab.ui.control.Label
        HSlider                    matlab.ui.control.Slider
    end

    
    properties (Access = protected)
                   
            H      =1/3;            %Kolmogorov case.
            q      = 0.00866;       % ratio between inner and outer scale   
            Rm     = 2*pi*.1/.005;  % dimentionless aperture radius 
            deltam = .05*2*pi/.005; % dimentionless separation in the target
            q0     = 1;
            Fm     = .0055;
            errorb = .0000001;      % calculating error
            s      = 0.0000001:.01:1;
            %gammas = gammaswave('divergent',app.s); % emiter type.
    end
    
    methods (Access = private)
        
        function results = weightint(app)
            [results, ~] = weight_integral_t(0,app.Fm, app.Rm,app.deltam,gammaswave('divergent',app.s), app.errorb, app.H, app.q, app.s);
            %clear errorc;
        end
        
        function results = weightgzt(app)
            [results, ~] = weight_integral_t(1,app.Fm*app.q^2,app.q*app.Rm,app.q*app.deltam,gammaswave('divergent',app.s),app.errorb,app.H,app.q0,app.s);
            results=app.q^(-2*app.H-1)*results;
        end
        
        function results = weightokt(app)
            [results, ~] = weight_integral_t(1,app.Fm*app.q^2, app.q*app.Rm, app.q*app.deltam, gammaswave('divergent',app.s), app.errorb, app.H, 0, app.s);
            results=app.q^(-2*app.H-1)*results;
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIAxes.XLim = [app.s(1) app.s(end)];
            app.UIAxes.XGrid= 'on';app.UIAxes.YGrid='on';
            plot(app.UIAxes,app.s,weightint(app),'b-',app.s,weightgzt(app),'g-',app.s,weightokt(app),'r-');
        end

        % Value changed function: FresnelNumberSlider
        function FresnelNumberSliderValueChanged(app, event)
            app.Fm = app.FresnelNumberSlider.Value;
            plot(app.UIAxes,app.s,weightint(app),'b-',app.s,weightgzt(app),'g-',app.s,weightokt(app),'r-');
            %app.UIAxes.YLim = [-1000 1000];
        end

        % Value changed function: DeltaSlider
        function DeltaSliderValueChanged(app, event)
            app.deltam = app.DeltaSlider.Value;
            plot(app.UIAxes,app.s,weightint(app),'b-',app.s,weightgzt(app),'g-',app.s,weightokt(app),'r-');
        end

        % Value changed function: ApertureSlider
        function ApertureSliderValueChanged(app, event)
            app.Rm = app.ApertureSlider.Value;
            plot(app.UIAxes,app.s,weightint(app),'b-',app.s,weightgzt(app),'g-',app.s,weightokt(app),'r-');
        end

        % Value changed function: QratioSlider
        function QratioSliderValueChanged(app, event)
            app.q = app.QratioSlider.Value;
            plot(app.UIAxes,app.s,weightint(app),'b-',app.s,weightgzt(app),'g-',app.s,weightokt(app),'r-');
        end

        % Value changed function: HSlider
        function HSliderValueChanged(app, event)
            app.H = app.HSlider.Value;
            plot(app.UIAxes,app.s,weightint(app),'b-',app.s,weightgzt(app),'g-',app.s,weightokt(app),'r-');
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create WeightFunctionsUIFigure and hide until all components are created
            app.WeightFunctionsUIFigure = uifigure('Visible', 'off');
            app.WeightFunctionsUIFigure.IntegerHandle = 'on';
            app.WeightFunctionsUIFigure.Position = [100 100 734 896];
            app.WeightFunctionsUIFigure.Name = 'Weight Functions';

            % Create UIAxes
            app.UIAxes = uiaxes(app.WeightFunctionsUIFigure);
            title(app.UIAxes, 'Comparing weight functions')
            xlabel(app.UIAxes, '\zeta')
            ylabel(app.UIAxes, 'dimensionless weight')
            app.UIAxes.PlotBoxAspectRatio = [1.31828442437923 1 1];
            app.UIAxes.FontName = 'Times';
            app.UIAxes.FontUnits = 'points';
            app.UIAxes.FontSize = 15;
            app.UIAxes.TitleFontSizeMultiplier = 1.5;
            app.UIAxes.TitleFontWeight = 'normal';
            app.UIAxes.Position = [48 360 640 519];

            % Create ErrorEditFieldLabel
            app.ErrorEditFieldLabel = uilabel(app.WeightFunctionsUIFigure);
            app.ErrorEditFieldLabel.HorizontalAlignment = 'right';
            app.ErrorEditFieldLabel.Position = [155 72 31 22];
            app.ErrorEditFieldLabel.Text = 'Error';

            % Create ErrorEditField
            app.ErrorEditField = uieditfield(app.WeightFunctionsUIFigure, 'numeric');
            app.ErrorEditField.Position = [201 72 100 22];

            % Create ExperimentParametersPanel
            app.ExperimentParametersPanel = uipanel(app.WeightFunctionsUIFigure);
            app.ExperimentParametersPanel.Title = 'Experiment Parameters';
            app.ExperimentParametersPanel.Position = [48 119 357 233];

            % Create FresnelNumberSliderLabel
            app.FresnelNumberSliderLabel = uilabel(app.ExperimentParametersPanel);
            app.FresnelNumberSliderLabel.HorizontalAlignment = 'right';
            app.FresnelNumberSliderLabel.Position = [1 168 91 22];
            app.FresnelNumberSliderLabel.Text = 'Fresnel Number';

            % Create FresnelNumberSlider
            app.FresnelNumberSlider = uislider(app.ExperimentParametersPanel);
            app.FresnelNumberSlider.Limits = [0 10000];
            app.FresnelNumberSlider.ValueChangedFcn = createCallbackFcn(app, @FresnelNumberSliderValueChanged, true);
            app.FresnelNumberSlider.Position = [124 178 215 3];
            app.FresnelNumberSlider.Value = 0.0055;

            % Create DeltaSliderLabel
            app.DeltaSliderLabel = uilabel(app.ExperimentParametersPanel);
            app.DeltaSliderLabel.HorizontalAlignment = 'right';
            app.DeltaSliderLabel.Position = [58 105 33 22];
            app.DeltaSliderLabel.Text = 'Delta';

            % Create DeltaSlider
            app.DeltaSlider = uislider(app.ExperimentParametersPanel);
            app.DeltaSlider.MajorTicks = [0 10 20 30 40 50 60 70 80 90 100];
            app.DeltaSlider.ValueChangedFcn = createCallbackFcn(app, @DeltaSliderValueChanged, true);
            app.DeltaSlider.Position = [124 114 215 3];
            app.DeltaSlider.Value = 62.8318530718;

            % Create ApertureSliderLabel
            app.ApertureSliderLabel = uilabel(app.ExperimentParametersPanel);
            app.ApertureSliderLabel.HorizontalAlignment = 'right';
            app.ApertureSliderLabel.Position = [40 44 52 22];
            app.ApertureSliderLabel.Text = 'Aperture';

            % Create ApertureSlider
            app.ApertureSlider = uislider(app.ExperimentParametersPanel);
            app.ApertureSlider.Limits = [10 700];
            app.ApertureSlider.ValueChangedFcn = createCallbackFcn(app, @ApertureSliderValueChanged, true);
            app.ApertureSlider.Position = [124 53 215 3];
            app.ApertureSlider.Value = 125.6637061436;

            % Create Panel
            app.Panel = uipanel(app.WeightFunctionsUIFigure);
            app.Panel.Title = 'Panel';
            app.Panel.Position = [420 119 279 233];

            % Create QratioSliderLabel
            app.QratioSliderLabel = uilabel(app.Panel);
            app.QratioSliderLabel.HorizontalAlignment = 'right';
            app.QratioSliderLabel.Position = [-3 169 42 22];
            app.QratioSliderLabel.Text = 'Q ratio';

            % Create QratioSlider
            app.QratioSlider = uislider(app.Panel);
            app.QratioSlider.Limits = [0 1];
            app.QratioSlider.MajorTicks = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
            app.QratioSlider.ValueChangedFcn = createCallbackFcn(app, @QratioSliderValueChanged, true);
            app.QratioSlider.Position = [55 178 213 3];
            app.QratioSlider.Value = 0.00866;

            % Create HSliderLabel
            app.HSliderLabel = uilabel(app.Panel);
            app.HSliderLabel.HorizontalAlignment = 'right';
            app.HSliderLabel.Position = [14 105 25 22];
            app.HSliderLabel.Text = 'H';

            % Create HSlider
            app.HSlider = uislider(app.Panel);
            app.HSlider.Limits = [0 1];
            app.HSlider.MajorTicks = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
            app.HSlider.ValueChangedFcn = createCallbackFcn(app, @HSliderValueChanged, true);
            app.HSlider.Position = [55 115 213 3];
            app.HSlider.Value = 0.333333333333333;

            % Show the figure after all components are created
            app.WeightFunctionsUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = test_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.WeightFunctionsUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.WeightFunctionsUIFigure)
        end
    end
end