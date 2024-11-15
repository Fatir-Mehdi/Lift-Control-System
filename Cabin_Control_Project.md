### **Project 02: Cabin Control System**

#### **1. Methodology**

The task involves controlling the lift cabin using a PLC system. The primary goal is to implement a lift control system where two PLC buttons (one to move up and one to move down) control the vertical movement of the lift. The floor on which the lift is currently located will be displayed using bit-coded control, and certain restrictions will be placed to prevent the lift from moving above the second floor or below the bottom floor.

To achieve this, we use **bit-coded control** to represent the lift's position and **flip-flops** to manage the floor display. The program will be implemented in the **Structured Text (ST)** language, following the provided specifications.

#### **2. Tools and Resources**

- **PLC (Lucas-Nülle PLC)**: Used for controlling the system.
- **CODESYS**: Programming environment for PLC programming.
- **PLC I/O Devices**: Inputs (buttons for controlling lift) and Outputs (for displaying floor and controlling the lift cabin).
- **Structured Text (ST)**: The programming language used to write the PLC logic.
- **Simulation Model**: A virtual or physical lift model for testing.

#### **3. Brief Description**

This project involves designing a **Lift Cabin Control System** that manages the movement of the lift cabin between the first, second, and bottom floors based on user input. The user can press buttons to move the lift up or down. The floor position is represented by two bits: FA_Bit0 and FA_Bit1, which are used to display the current floor. Additionally, **reed contacts** for each floor will be used to prevent the lift from moving beyond the allowed floors.

The system will also implement a restriction to ensure that:
- The lift does not move higher than the second floor.
- The lift does not move below the bottom floor.

#### **4. Steps**

1. **System Initialization**:
   - Configure the PLC with necessary input and output devices.
   - Define variables to store the states of the buttons, reed contacts, and floor display bits.

2. **Input Configuration**:
   - Define buttons to control the lift's movement (up and down).
   - Define reed contacts for the first and second floors to prevent over-travel.

3. **PLC Logic Programming (Structured Text)**:
   - Program the logic to move the lift up or down based on the button presses.
   - Use flip-flops for controlling the floor display and restricting movement based on the floor.

4. **Testing and Validation**:
   - Simulate the system to test if the lift responds correctly to the up and down button presses.
   - Check if the floor display updates as expected and if the movement restrictions work correctly.

5. **Debugging and Optimization**:
   - Fix any issues or errors in the logic and ensure the program runs efficiently.

6. **Final Validation**:
   - Validate the complete system to ensure that the lift moves properly between floors and displays the correct floor.

#### **5. Skills Acquired**

Through this project, you will learn:
- **PLC Programming**: How to program using Structured Text (ST) for controlling mechanical systems like a lift cabin.
- **Control Systems**: Understanding how to control lift cabins with button inputs and display floor positions using bits.
- **Digital Logic**: Implementing flip-flops to manage the state of floor displays and control logic.
- **System Debugging**: Troubleshooting and debugging PLC logic to ensure correct operation.
- **Automation Design**: Designing and simulating a complete lift control system.

#### **6. Results**

- The lift will move up or down based on button presses.
- The floor position will be correctly displayed using FA_Bit0 and FA_Bit1.
- The movement will be restricted such that the lift will not exceed the second floor or go below the bottom floor.
- The system will work as expected in a simulated or physical environment.

#### **7. Importance of the Project**

This project is important as it demonstrates the fundamental concepts of **automated control systems** using PLCs. The ability to control mechanical systems like lifts is essential in industries, and this project provides hands-on experience with controlling movement, implementing restrictions, and managing floor displays. These skills are foundational for more complex automation tasks in real-world systems.

#### **8. Conclusion**

The cabin control project effectively demonstrates how PLCs can be used to control elevator systems and restrict movement to specific floors. The use of flip-flops to control floor display and ensure safe movement adds robustness to the system. The project not only reinforces PLC programming skills but also helps understand the integration of mechanical control with automation systems.

---

### **Program Code for Cabin Control (Structured Text)**

```pascal
VAR
    Manual_lift_up : BOOL;        (* Input for the up button *)
    Manual_lift_down : BOOL;      (* Input for the down button *)
    Floor_position_1 : BOOL;      (* Reed contact for floor 1 *)
    Floor_position_2 : BOOL;      (* Reed contact for floor 2 *)
    FA_Bit0 : BOOL;               (* Bit for floor 0 *)
    FA_Bit1 : BOOL;               (* Bit for floor 1 *)
    Lift_move_up : BOOL;         (* Output for moving the lift up *)
    Lift_move_down : BOOL;       (* Output for moving the lift down *)
END_VAR

(* Floor display logic using flip-flops *)
IF FA_Bit0 AND NOT FA_Bit1 THEN
    (* Lift is at the bottom floor *)
    Floor_position_1 := TRUE;  (* Display bottom floor *)
    Floor_position_2 := FALSE;
ELSIF NOT FA_Bit0 AND FA_Bit1 THEN
    (* Lift is at the first floor *)
    Floor_position_1 := FALSE;
    Floor_position_2 := TRUE;  (* Display first floor *)
ELSIF FA_Bit0 AND FA_Bit1 THEN
    (* Lift is at the second floor *)
    Floor_position_1 := FALSE;
    Floor_position_2 := FALSE;
END_IF

(* Lift control logic *)
IF Manual_lift_up AND NOT Floor_position_2 THEN
    (* If the lift is not at the second floor, move up *)
    Lift_move_up := TRUE;
    Lift_move_down := FALSE;
ELSIF Manual_lift_down AND NOT Floor_position_1 THEN
    (* If the lift is not at the bottom floor, move down *)
    Lift_move_up := FALSE;
    Lift_move_down := TRUE;
ELSE
    (* If lift is at the limit, stop it *)
    Lift_move_up := FALSE;
    Lift_move_down := FALSE;
END_IF
```

### **Explanation of the Code:**
1. **Inputs**:
   - `Manual_lift_up`: Button press to move the lift up.
   - `Manual_lift_down`: Button press to move the lift down.
   - `Floor_position_1`, `Floor_position_2`: Reed contacts for the first and second floors to prevent over-travel.
   - `FA_Bit0`, `FA_Bit1`: Bits used to display the current floor.

2. **Floor Display Logic**:
   - The `FA_Bit0` and `FA_Bit1` are used to manage which floor the lift is on.
   - The reed contacts determine which floor the lift is currently on and update the display accordingly.

3. **Lift Control Logic**:
   - The lift will move up if the "up" button is pressed, provided it is not already at the second floor.
   - The lift will move down if the "down" button is pressed, provided it is not already at the bottom floor.
   - If the lift reaches a floor limit, it will stop moving.
