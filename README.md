#Kitchissippi Delta 03.12

The Kitchissippi Delta is a prototype delta style 3D printer.<br>
It is designed as a RepRap styled printer that uses many easily available parts.

The early versions have proven that the concept works well, however it requires refinement.<br>
Home Page: [Kitchissippi Robotics](https://kitchissippi-robotics.com/3d-printers/kitchissippi-delta/)

##Version Notes

v3.12 - Working on new OpenSCAD design, based on some of the work done with the Kitchissippi Gemini 3D Printer.

##Build and Design Notes

###Pin Swivels

- Each swivel joint has <i>(6) Pins</i> inserted into a <u>Pin Swivel Arm</u>
- Each <u>Rod End</u> will be attached to the rod and glued into place while level
- <u>Rod Ends</u> will then snap-fit over the pins on the <u>Pin Swivel Arm</u>
- This is done for two rods per axis and on both ends of the rods
- This creates a paralellogram of two rod assemblies with a <u>Pin Swivel Arm<u> at each end

####Parts for the assembly:
- (6) 300mm x 6.4mm round aluminum rod
- (36) 7.8mm x 3.6mm round steel bicycle chain pins (note be careful when using chain scraps that all 36 pins are the same size)
- (6) printed <u>Pin Swivel Arm</u>
- (12) printed <u>Rod End</u>


###Drive System:

- GT2 timing belt driven on machined aluminum GT2-20 pulleys with 608zz bearing idlers.
- Linear motion achieved on 1/4" polished steel tubing, with 608zz carriage sytem based on the K-02 prototype carriage concept.
- Consideration was given to spectra-line drive systems, however the relative cost of GT2 belt and the extra effort required seems economically unsound.
- Standard NEMA17 stepper motors.

###Extrusion:

- 1.75mm filament driven through 2mm ID / 4mm OD PTFE tubing.
- Carriage and mounts are based around the current J Head design with no consideration for other groovemounted hotends at this time - it will be made more modular in the future
- Fan shrouding is designed for the needs of a J Head running at elevated temperatures, there is a 25mm x 10mm fan aimed at the cooling fins in the PEEK/cold-end portion of the design - always on.
- Ducting may be beneficial to other similar hotends, however I would not recommend using the Carriage - Core piece with an all-metal hotend unless it has been printed in a high temperature plastic, such as ABS or Nylon
- Dual 25mm x 10mm fans ducted around the hotend towards the print immediately below the carriage for plastics that need active cooling - software controlled.

###Movement:

- Universal joints created using pins extracted from used bicycle chain.
- Joints have a snap-assemble design but are not very conducive to repeated disassembly.
- Using 1/4" solid aluminum rod for the carriage arms, will need to be glued into the universal joint arms.
- The control arms parallelogram borrows the swivel bar concept from the DeltaPi design, although this implementation is quite different

###Calibration:

- Initial build will not have consideration for auto-levelling.<br>
  Once the base design has matured from an initial testing prototype to a working proof consideration can be applied to such advanced topics.

###Assembly Notes:

- The universal joint arms may split if you try to force them onto the carriage arms.<br>
  I recommend printing them in PLA and then dipping them in hot water for 10 seconds to soften the plastic before carefully pushing them over the rods for a dry-run fitting.<br>
  Let them cool on the rod before removing them to dry them off so that you retain the internal shape.<br>

- The universal joint has some play to it it's movement, this has mostly been eliminated in current prototypes.<br>
  There is provision for spring attachments between the effector arm pairs on each side, like on the 3DR - this should help keep everything tight<br>
  Apply thick grease to the pin holders on the carriages.<br>
