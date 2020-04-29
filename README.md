# Standing Wave Simulator
A MatLab built simulator which is intended to display the interference between two sound waves. This simulator allows users to select the amplitude of their two sound waves, as well as control which waves are activated using the switches at the bottom of the simulator.

## Getting Started

### Prerequisutes
In order to run the simulator, Matlab (R2019a or higher) will have to be open and the path should be pointing to the location of the files from this repository.
```
>> cd location-of-repo-download
```
### Staring the Simulator
Starting the simulator only requires the command window. **Make sure that the command window path is the same path as where the repo is saved**
All you need to do is enter the following command into the command window:
```
>> standingwavedemo_exported
```
After pressing enter, the simulator should pop up in a window.

## Working with the Simulator

### Analyzing the Graphs
There are three graphs in the simulator. The two smaller graphs depict sound waves initially with the same amplitude, but moving in opposite directions. The larger graph displays the constructive and deconstructive interference between the 2 sound waves. When the two sound waves have the same amplitude a standing wave can be seen in the larger graph.

### Enabling the Waves
In order to begin the simulation, first click ***start sim*** then you can enable each graph by turning on their corresponding switches. When a graph is enabled, the lamp for that graph will turn green to signal that the startup was successful.

### Amplitude Adjustment
The simulator gives one the ability to modify each of the sound waves amplitude using the knobs. The knobss can be set at any value between 1-10, and the value the knob is set to will be what the amplitude of the corrresponding sine wave is.

### Quitting and Reset
If you want to reset the simulator or quit, you can press the corresponding buttons in the simulator to achieve these actions.

## Built With
* MatLab - Version R2019a

## Authors
* **Jacob Rajah** wrote all the code for this simulator using **mlapp**

## Goals
The goal of this project was to practice working with matlab and its GUI builder, and to help visualize a physical concept.
