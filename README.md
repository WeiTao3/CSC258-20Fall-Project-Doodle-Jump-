# CSC258-20Fall-Project-Doodle-Jump-
This is the repository for CSC258 2020 Fall Final Project of Doodle Jump

- Descriptions:
  - The content of this project is about the mobile game Doodle Jump.
  - The project is implemented by MIPS assmebly language.

- General Instructions:
  - The " s " key will be used to start and restart the game.
  - The " j " key makes the Doodler move to the left.
  - The " k " key makes the Doodler move to the right.

- Quick start: MARS
  1. Download MARS http://courses.missouristate.edu/kenvollmar/mars/download.htm
  2. Open the file called doodlejump.s in MARS
  3. Set up display: Tools > Bitmap display
     Set parameters like unit width & height (8), display width & height (256) and base address 0x10008000 for display. 
     Click “Connect to MIPS” once these are set.
  4. Setup keyboard: Tools > Keyboard and Display MMIO Simulator 
     Click “Connect to MIPS”
  5. Run your program:
     Run > Assemble
     Run > Go (to start the run)
     Input the character j or k in Keyboard area (bottom white box) in Keyboard and
     Display MMIO Simulator window
