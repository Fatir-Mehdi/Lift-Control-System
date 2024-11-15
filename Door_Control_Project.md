### **Project 1: Door Control System**

#### **1. Methodology**

The methodology for this project is to use a **PLC (Programmable Logic Controller)** to control the operation of elevator doors based on button presses. The system should allow the doors to open and close based on a signal, and it will employ basic PLC logic in the form of Structured Text (ST) programming language to manage the inputs (buttons) and outputs (door control).

The project will use a **feedback loop** where an input from the user (button press) triggers an output (door open/close). The process will be controlled by sensors and logic, ensuring that each action (open or close) happens when the signal conditions are met.

#### **2. Tools and Resources**

- **PLC (Lucas-Nülle PLC)**: The primary control unit for this project.
- **CODESYS**: The programming environment for writing and testing PLC programs.
- **PLC I/O Devices**: Inputs (buttons) and Outputs (door control signals).
- **Structured Text (ST)**: The programming language used to implement the logic.
- **Simulation Model**: A virtual or physical lift model for testing.

#### **3. Brief Description**

In this project, the goal is to control the elevator doors using PLC. The project involves managing inputs such as floor request buttons and signals to open or close the door. The system receives a button signal for opening and closing doors. If the signal is set to "1", the door opens, and if the signal is set to "0", the door closes.

The main function of the project is to ensure that the doors open when the button is pressed and close when the signal is reset. The door control system is triggered through the use of the PLC, and feedback signals are used to indicate the status of the doors.

#### **4. Steps**

1. **System Initialization:**
   - Configure the PLC with input and output devices.
   - Define the required variables for controlling the doors and reading inputs.

2. **Input Configuration:**
   - Define inputs for cabin floor request buttons and door open/close signals.
   - Assign boolean values to inputs that detect whether the door should be open or closed.

3. **PLC Logic Programming (Structured Text):**
   - Program the logic to open and close the doors based on the inputs (using a simple conditional check).
   - Control the door based on signals that represent whether the door should open or close.
   
4. **Testing and Validation:**
   - Test the system in a simulated or physical environment to check if the door responds correctly to the button signals.
   - Ensure that the door opens and closes as expected.

5. **Debugging and Optimization:**
   - Identify and fix any issues that arise during testing, such as logic errors or incorrect output.

6. **Final Validation:**
   - Validate the system in all possible input conditions (button pressed, reset).

#### **5. Skills Acquired**

By completing this project, you will acquire the following skills:
- **PLC Programming**: Learn to write and implement logic in Structured Text (ST) for PLCs.
- **Control Systems**: Understand how PLCs control mechanical systems like doors and manage inputs/outputs.
- **Debugging**: Learn to troubleshoot and debug PLC-based systems.
- **Input-Output Management**: Understand the role of inputs (buttons) and outputs (signals) in automated systems.
- **Automation Testing**: Gain hands-on experience with testing automation systems for correctness.

#### **6. Results**

- The doors will open and close successfully when the corresponding button is pressed.
- The door control system will behave as expected based on input signals, opening the door when a signal is set to "1" and closing when set to "0".
- The system will be able to respond to multiple floor requests, simulating the basic behavior of a lift's door control mechanism.

#### **7. Importance of the Project**

This project demonstrates the **fundamental principles of automation and control systems**, which are crucial in various industries. The ability to control mechanical systems using PLCs is a core skill in industrial automation, and this project shows how basic programming skills can be applied to real-world scenarios like elevator door control. The project also emphasizes the importance of designing robust, real-time systems that are reliable and respond correctly to user inputs.

#### **8. Conclusion**

In conclusion, this project helped demonstrate the capabilities of PLCs in controlling systems like elevator doors. The application of Structured Text programming allowed for efficient control of the doors using input signals, and the final system was tested to ensure its functionality. The project reinforced the importance of PLC programming and real-time control in automation, and the skills gained will be essential for more advanced projects involving automation and industrial control.

---

### **Program Code for Door Control (Structured Text)**

```pascal
VAR
    Select_door_open_close : BOOL;  (* Input to select open or close door *)
    Door_open_close : BOOL;         (* Output to open/close door *)
    C_T_C_2 : BOOL;                 (* Input for floor request button 2 *)
END_VAR

(* Door control logic *)

(* If Select_door_open_close is set, open the door *)
IF Select_door_open_close AND C_T_C_2 THEN
    Door_open_close := TRUE;      (* Open door *)
ELSE
    Door_open_close := FALSE;     (* Close door *)
END_IF
```

### **Explanation of the Code:**
1. **Inputs**:
   - `Select_door_open_close`: A boolean input that determines if the door should be opened or closed.
   - `C_T_C_2`: A boolean input indicating a floor request button.

2. **Logic**:
   - If both `Select_door_open_close` and `C_T_C_2` are **TRUE**, the door will open (`Door_open_close := TRUE`).
   - If either input is **FALSE**, the door will remain closed (`Door_open_close := FALSE`).

3. **Outputs**:
   - The output `Door_open_close` controls the actual door, opening or closing it based on the inputs.

This program should be tested in the CODESYS environment, and it can be simulated using a PLC and connected I/O devices (buttons, relays, etc.).
