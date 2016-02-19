#Kitchissippi Delta 3D Printer

The Kitchissippi Delta is a prototype delta style 3D printer designed by Brian Cantin.<br>

The early versions have proven that the concept works well, however it requires refinement.<br>
Home Page: [Kitchissippi Robotics](https://kitchissippi-robotics.com/3d-printers/kitchissippi-delta/)

## Version Notes

v3.2 - OpenSCAD Based design start, largely inspired by the Kitchissippi Robotics Gemini 3D printer work in OpenSCAD. Much cleanup of the build is in progress and start of a common code library.

## Design Philosophy

This 3D printer is born out of a philosophy that encompasses many points:

1. As much of the machine should be made out of 3D printed plastic items as is reasonably possible, and these parts should fit within the print area of a Prusa Mendel i2.
   Frame joining pieces, effector, linear carriages, etc. - the parts that make this machine fit together and be an FFM printer are all plastic and smaller than 200mm x 200m x 100mm. Some parts may not fit within the restrictions of PrintrBot or Huxley models, but this has not been verified nor is it a focus. (Sorry)

2. As much of the hardware which cannot be 3D printed should be commonly available at North American hardware store chains.
  * Frame is made from 3/4" steel and aluminum square tubing stocked by most large chain stores
  * Parallelogram rods are made from round aluminum rods stocked by most large chain stores
  * Core design uses SAE hardware as much as possible, the primary exceptions being NEMA17 bolts as the motor format is metric by nature - I'm not going to re-drill and re-thread my motors and neither should you.
  * Build platform uses 1' x 1' mirror tile

3. If possible, recycled parts from commonly found machinery should be used.
  * The belt drive uses 608zz bearings for the idlers. These can be found in unused skateboards or rollerblades, or easily available from sporting goods stores that sell such items.
  * All joints use bicycle chain pins - these are hardened steel pins and can be extracted with an inexpensive tool from old chains or even sourced from new chains which are quite inexpensive.

4. Use standard RepRap electronics where possible.
  * This machine is designed around the RUMBA controller but could easily be controlled with a RAMPS + ATMega board
  * This machine is designed around a 12v LED power supply, but can be also run on a salvaged ATX PSU from a computer since it uses the 12v standard.

5. This design is scalable.
  * By changing the vertical tubing you can realistically make the build volume as large or small as you desire.
  * By changing the horizontal frame tubing and parallelogram arm lengths proportionally, you can make the build area as large or small as you desire.

6. Make the design parametric where possible.
  * This point doesn't hold as much priority but is kept in consideration.
  * The SAE bolt sizing chosen for much of the prototype builds is quite close to M4 and for the most part one should be able to directly replace the SAE hardare with metric if care is taken during assembly.
  * As the design gets migrated into an SCAD design, the options for this will increase.


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
