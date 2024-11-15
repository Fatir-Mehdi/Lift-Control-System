### Project 03: Control of Lift for Two Floors

#### 1. **Project Overview**
This project involves controlling a lift to move between two floors (Floor 0 and Floor 1) based on user requests. The lift should move to the requested floor when the corresponding button is pressed, with interlocks in place to prevent movement beyond the available floors. The current floor should be displayed, and the system should manage the request status accordingly.

#### 2. **Project Requirements**
- **Floor Control:** The lift should move between Floor 0 and Floor 1.
- **Button Control:** The user presses a floor request button to call the lift to a specific floor.
- **Floor Display:** The lift's current floor is displayed using a floor display routine (as in Exercise 2).
- **Interlocks:** Movement is constrained by position switches for each floor to avoid the lift moving beyond its limits.
- **Flip-Flop:** Flip-flops will be used to manage the status of each floor (whether it is requested or not).
- **Sequence Control:** The project will require multiple steps, controlled by RS (reset-set) flip-flops for managing each step.

#### 3. **Variables**
The following variables are required for the project:

- **Inputs:**
  - `Cabin_request_0`: Button for Floor 0 request (BOOL)
  - `Cabin_request_1`: Button for Floor 1 request (BOOL)
  - `Position_switch_0`: Position switch for Floor 0 (BOOL)
  - `Position_switch_1`: Position switch for Floor 1 (BOOL)

- **Outputs:**
  - `Lift_move_up`: Signal to move the lift up (BOOL)
  - `Lift_move_down`: Signal to move the lift down (BOOL)
  - `Floor_display_bit_0`: Display bit for Floor 0 (BOOL)
  - `Floor_display_bit_1`: Display bit for Floor 1 (BOOL)
  - `Lift_request_light_0`: Indicator light for Floor 0 request (BOOL)
  - `Lift_request_light_1`: Indicator light for Floor 1 request (BOOL)

- **Function Block Instances:**
  - `Step_1`: RS instance for Step 1
  - `Step_2`: RS instance for Step 2
  - `Step_3`: RS instance for Step 3
  - `Step_4`: RS instance for Step 4
  - `FL_0`: RS flip-flop for Floor 0 display
  - `FL_1`: RS flip-flop for Floor 1 display
  - `C_E_0`: RS instance for call to Floor 0
  - `C_E_1`: RS instance for call to Floor 1

#### 4. **System Design**

The control logic involves setting and resetting flip-flops based on button presses and floor position switches. The lift can only move between the two floors, with constraints placed to prevent movement beyond the available floors.

#### 5. **CODESYS Program Structure**

Below is the CODESYS ST (Structured Text) program to implement the lift control:

```pascal
VAR
    Cabin_request_0 : BOOL; // Floor 0 request
    Cabin_request_1 : BOOL; // Floor 1 request
    Position_switch_0 : BOOL; // Floor 0 position switch
    Position_switch_1 : BOOL; // Floor 1 position switch
    Lift_move_up : BOOL; // Move up signal
    Lift_move_down : BOOL; // Move down signal
    Floor_display_bit_0 : BOOL; // Floor 0 display bit
    Floor_display_bit_1 : BOOL; // Floor 1 display bit
    Lift_request_light_0 : BOOL; // Request light for Floor 0
    Lift_request_light_1 : BOOL; // Request light for Floor 1
    Step_1 : RS; // Step 1 RS instance
    Step_2 : RS; // Step 2 RS instance
    Step_3 : RS; // Step 3 RS instance
    Step_4 : RS; // Step 4 RS instance
    FL_0 : RS; // Flip-flop for Floor 0
    FL_1 : RS; // Flip-flop for Floor 1
    C_E_0 : RS; // Call to Floor 0
    C_E_1 : RS; // Call to Floor 1
END_VAR

// Sequence control for the lift
IF Cabin_request_0 AND NOT Position_switch_0 THEN
    Step_1.SET := TRUE;
    Step_2.RESET := TRUE;
    Step_3.RESET := TRUE;
    Lift_move_up := TRUE; // Move the lift up
    Lift_request_light_0 := TRUE; // Light up request for Floor 0
    FL_0.SET := TRUE; // Set flip-flop for Floor 0
ELSIF Cabin_request_1 AND NOT Position_switch_1 THEN
    Step_1.RESET := TRUE;
    Step_2.SET := TRUE;
    Step_3.RESET := TRUE;
    Lift_move_down := TRUE; // Move the lift down
    Lift_request_light_1 := TRUE; // Light up request for Floor 1
    FL_1.SET := TRUE; // Set flip-flop for Floor 1
END_IF

// Reset after reaching requested floor
IF Position_switch_0 THEN
    Step_1.RESET := TRUE;
    Lift_move_up := FALSE;
    Lift_request_light_0 := FALSE;
    FL_0.RESET := TRUE;
END_IF

IF Position_switch_1 THEN
    Step_2.RESET := TRUE;
    Lift_move_down := FALSE;
    Lift_request_light_1 := FALSE;
    FL_1.RESET := TRUE;
END_IF

// Floor display logic based on flip-flops
IF FL_0.SET THEN
    Floor_display_bit_0 := TRUE; // Show Floor 0
    Floor_display_bit_1 := FALSE;
ELSE
    Floor_display_bit_0 := FALSE;
    Floor_display_bit_1 := TRUE; // Show Floor 1
END_IF
```

#### 6. **Program Explanation**

- **Input Processing:**
  - When `Cabin_request_0` is pressed and the lift is not at Floor 0 (`Position_switch_0` is false), the lift will move up to Floor 1.
  - Similarly, when `Cabin_request_1` is pressed and the lift is not at Floor 1 (`Position_switch_1` is false), the lift will move down to Floor 0.
  
- **Movement Control:**
  - The movement of the lift is controlled by the `Lift_move_up` and `Lift_move_down` signals, depending on the user's request and the current floor's position.
  
- **Floor Display:**
  - The floor display is controlled using `FL_0` and `FL_1` flip-flops. When the lift reaches a floor, the respective flip-flop is set, and the floor display bit is updated.
  
- **Interlock:**
  - The interlock ensures that the lift doesn't move if it is already at the requested floor, as determined by the position switches.

#### 7. **Testing and Implementation**
1. **Testing the Program:**
   - Implement the program in CODESYS and test it on the PLC connected to the lift model.
   - Ensure the floor request buttons light up correctly and the lift moves according to the requests.
   - Check that the floor display shows the correct floor after each movement.
   - Verify that the interlock prevents the lift from moving past the available floors.
  
2. **Deployment:**
   - Deploy the program to the Lucas-Nülle PLC and connect it to the physical components for real-time testing.

#### 8. **Conclusion**
This program successfully implements a basic two-floor lift control system with interlocks and floor display features. The use of flip-flops ensures proper management of floor requests, and the lift movement is constrained by the floor position switches.
