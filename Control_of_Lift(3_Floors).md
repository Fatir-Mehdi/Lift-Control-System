### Project 04: Control of Lift for 3 Floors

This project focuses on creating a control routine for a lift serving three floors. The lift should handle requests and movements between floor 0, floor 1, and floor 2. The control sequence is more complex than for two floors due to additional floors and movement constraints. The program will be designed using CODESYS programming environment and involves multiple steps for the operation of the lift.

### Project Structure

#### **1. Objective:**
- Control a lift serving three floors (0, 1, and 2).
- The lift should respond to calls and move to the requested floor.
- Handle transitions for going up or down between floors.
- Display the current floor and handle requests for multiple floors at once.
  
#### **2. Hardware Requirements:**
- Inputs for buttons and position switches.
- Outputs for controlling the lift movement and display.
- PLC system: Lucas-Nülle PLC and CODESYS environment.

#### **3. Variables:**
- **Step_1** - RS Instance for Step 1 (Initial step).
- **Step_2** - RS Instance for Step 2.
- **Step_3** - RS Instance for Step 3.
- **Step_4** - RS Instance for Step 4.
- **Step_FL_0** - RS Instance for Step 0 (Floor 0).
- **Step_FL_1** - RS Instance for Step 1 (Floor 1).
- **Step_FL_2** - RS Instance for Step 2 (Floor 2).
- **C_E_0** - RS for Call_Elevator_0 (Call from floor 0).
- **C_E_1** - RS for Call_Elevator_1 (Call from floor 1).
- **C_E_2** - RS for Call_Elevator_2 (Call from floor 2).
- **P_F_0** - Position switch for Floor 0.
- **P_F_1** - Position switch for Floor 1.
- **P_F_2** - Position switch for Floor 2.
- **FL_0** - Flip-flop for Floor 0 display.
- **FL_1** - Flip-flop for Floor 1 display.
- **FL_2** - Flip-flop for Floor 2 display.
- **Lift_up** - Command to lift up.
- **Lift_down** - Command to lift down.
- **Lift_stop** - Command to stop the lift.

#### **4. Program Logic:**

The control sequence for the lift is divided into several steps:

1. **Step 0 (Initial Step):**
   - The lift is initially at floor 0. The sequence starts here.
   - Transition conditions: Call elevator for floor 1 (`C_E_1`) or floor 2 (`C_E_2`).

2. **Step 1 (Move Up to Floor 1):**
   - Lift moves up to floor 1.
   - Transition condition: Lift reaches floor 1 or is called to move back down.

3. **Step FL_1 (Floor 1):**
   - Handle requests for floor 1.
   - Transition conditions: Move to floor 2 (`C_E_2`), or go back to floor 0 (`C_E_0`).

4. **Step 2 (Move Down to Floor 0):**
   - Lift moves down to floor 0.
   - Transition condition: Lift reaches floor 0.

5. **Step FL_2 (Floor 2):**
   - Handle requests for floor 2.
   - Transition conditions: Move to floor 1 (`C_E_1`), or go down to floor 0.

6. **Step 3 (Move Up to Floor 2):**
   - Lift moves up to floor 2.
   - Transition condition: Lift reaches floor 2.

7. **Step 4 (Move Down to Floor 1):**
   - Lift moves down to floor 1.
   - Transition condition: Lift reaches floor 1.

### **CODESYS Implementation (ST):**

The implementation uses Structured Text (ST). Below is the structured code in **Structured Text (ST)** for the lift control system.

```pascal
VAR
    Init: BOOL := FALSE; (* Initialization flag *)
    Step_1: RS; (* Step 1 RS Instance *)
    Step_2: RS; (* Step 2 RS Instance *)
    Step_3: RS; (* Step 3 RS Instance *)
    Step_4: RS; (* Step 4 RS Instance *)
    Step_FL_0: RS; (* Step for Floor 0 *)
    Step_FL_1: RS; (* Step for Floor 1 *)
    Step_FL_2: RS; (* Step for Floor 2 *)

    C_E_0: BOOL; (* Call from Floor 0 *)
    C_E_1: BOOL; (* Call from Floor 1 *)
    C_E_2: BOOL; (* Call from Floor 2 *)

    Lift_up: BOOL; (* Lift up command *)
    Lift_down: BOOL; (* Lift down command *)
    Lift_stop: BOOL; (* Lift stop command *)

    P_F_0: BOOL; (* Position switch for floor 0 *)
    P_F_1: BOOL; (* Position switch for floor 1 *)
    P_F_2: BOOL; (* Position switch for floor 2 *)

    FL_0: BOOL; (* Floor 0 display *)
    FL_1: BOOL; (* Floor 1 display *)
    FL_2: BOOL; (* Floor 2 display *)
    
END_VAR

(* Initialization step *)
IF NOT Init THEN
    Step_1 := TRUE;
    Step_2 := FALSE;
    Step_3 := FALSE;
    Step_4 := FALSE;
    Init := TRUE;
END_IF

(* Step 1: Move to Floor 1 *)
IF Step_1 THEN
    Lift_up := TRUE;
    Step_1 := FALSE;
    IF C_E_1 OR C_E_2 THEN
        Step_FL_1 := TRUE;
    END_IF
END_IF

(* Step FL_1: Handle requests at Floor 1 *)
IF Step_FL_1 THEN
    IF C_E_0 THEN
        Lift_down := TRUE;
        Step_FL_1 := FALSE;
        Step_2 := TRUE;
    ELSIF C_E_2 THEN
        Lift_up := TRUE;
        Step_FL_1 := FALSE;
        Step_3 := TRUE;
    END_IF
END_IF

(* Step 2: Move down to Floor 0 *)
IF Step_2 THEN
    Lift_down := TRUE;
    IF P_F_0 THEN
        Lift_stop := TRUE;
        Step_2 := FALSE;
    END_IF
END_IF

(* Step FL_2: Handle requests at Floor 2 *)
IF Step_FL_2 THEN
    IF C_E_1 THEN
        Lift_down := TRUE;
        Step_FL_2 := FALSE;
        Step_4 := TRUE;
    END_IF
END_IF

(* Step 3: Move up to Floor 2 *)
IF Step_3 THEN
    Lift_up := TRUE;
    IF P_F_2 THEN
        Lift_stop := TRUE;
        Step_3 := FALSE;
    END_IF
END_IF

(* Step 4: Move down to Floor 1 *)
IF Step_4 THEN
    Lift_down := TRUE;
    IF P_F_1 THEN
        Lift_stop := TRUE;
        Step_4 := FALSE;
    END_IF
END_IF

(* Display current floor *)
FL_0 := P_F_0;
FL_1 := P_F_1;
FL_2 := P_F_2;
```

### **Explanation of Key Steps:**

1. **Initialization:**
   - The initial state (`Init`) is set to FALSE to start the program, and Step 1 is executed.
   
2. **Step Logic:**
   - For each step, depending on the lift's current position (using position switches), the lift will either move up or down.
   - Each step transitions to the next step based on call requests from different floors.

3. **Floor Requests:**
   - The program handles the floor requests and ensures that the lift responds to the correct calls.
   
4. **Floor Display:**
   - The current floor is displayed using flip-flops (`FL_0`, `FL_1`, `FL_2`) for each floor.

