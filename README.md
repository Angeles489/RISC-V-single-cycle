# RISC-V Single Cycle Processor — Verilog

Implementación de un procesador RISC-V de ciclo único (single-cycle) en Verilog, simulado con **Questa Altera Starter FPGA Edition** (ModelSim). El diseño soporta un subconjunto de instrucciones RV32I: instrucciones tipo R, tipo I (incluyendo `addi` y `lw`), tipo S (`sw`), tipo B (`beq`) y tipo J (`jal`).

---

## Módulos

| Archivo | Módulo | Descripción |
|---|---|---|
| `top.v` | `top` | Datapath completo, conecta todos los módulos |
| `program_counter.v` | `program_counter` | Registro del PC con reset asíncrono activo alto |
| `instruction_memory.v` | `instruction_memory` | Memoria ROM, carga instrucciones desde `instrMem.hex` |
| `register_file.v` | `register_file` | 32 registros × 32 bits, escritura en flanco positivo |
| `control_unit.v` | `control_unit` | Instancia MAIN_Decoder + ALU_control |
| `MAIN_Decoder.v` | `MAIN_Decoder` | Decodificador principal por opcode |
| `ALU_control.v` | `ALU_control` | Genera `ALUControl` a partir de `ALUOp` + `funct3` + `funct7` |
| `ALU.v` | `ALU` | Unidad aritmético-lógica (ADD, SUB, AND, OR, SHL) |
| `immediate_generator.v` | `immediate_generator` | Extensión de signo para inmediatos I/S/B/J |
| `mux.v` | `mux` | MUX parametrizable por número de entradas |
| `adder.v` | `adder` | Sumador de 32 bits (PC+4 y PC+Imm) |
| `branch_comparator.v` | `branch_comparator` | Compara RD1 y RD2, genera señal `zero` |
| `data_memory.v` | `data_memory` | Memoria RAM de datos, escritura síncrona |
| `top_tb.v` | `top_tb` | Testbench con clock, reset y monitor de registros |

---

## Instrucciones soportadas

| Tipo | Instrucciones | Opcode |
|---|---|---|
| R-type | `add`, `sub`, `and`, `or` | `0110011` (51) |
| I-type aritmético | `addi` | `0010011` (19) |
| I-type carga | `lw` | `0000011` (3) |
| S-type | `sw` | `0100011` (35) |
| B-type | `beq` | `1100011` (99) |
| J-type | `jal` | `1101111` (111) |

---

## Estructura de archivos

```
Riscv_single_cycle/
├── top.v
├── program_counter.v
├── instruction_memory.v
├── register_file.v
├── control_unit.v
├── MAIN_Decoder.v
├── ALU_control.v
├── ALU.v
├── inmediate_generator.v
├── mux.v
├── adder.v
├── branch_comparator.v
├── data_memory.v
├── top_tb.v
├── instrMem.hex
└── README.md
```

---

## Formato del archivo de instrucciones

El archivo `instrMem.hex` contiene las instrucciones en hexadecimal, una por línea, en formato little-endian word. Ejemplo del programa de prueba:

```
00500293
00a00313
00628533
```

Que corresponde al programa:

```asm
addi x5,  x0, 5      # x5 = 5
addi x6,  x0, 10     # x6 = 10
add  x10, x5, x6     # x10 = x5 + x6 = 15
```

> La memoria de instrucciones está dimensionada para 32 palabras (128 bytes). Las posiciones sin instrucción deben llenarse con `00000013` (NOP = `addi x0, x0, 0`) para evitar valores indefinidos en la simulación.

---

## Simulación

### Herramienta
- **Questa Altera Starter FPGA Edition 2025.2** (ModelSim compatible)

### Resultado esperado

```
instr_mem[0] = 00500293
instr_mem[1] = 00a00313
instr_mem[2] = 00628533

TIME=21000 | PC=00000000 | INSTR=00500293 | ALUResult=00000005 | x5= 5 | x6= 0 | x10= 0
TIME=25000 | PC=00000004 | INSTR=00a00313 | ALUResult=0000000a | x5= 5 | x6= 0 | x10= 0
TIME=35000 | PC=00000008 | INSTR=00628533 | ALUResult=0000000f | x5= 5 | x6=10 | x10= 0

-----------------------------------
x5  =  5
x6  = 10
x10 = 15
-----------------------------------
```

---

## Notas de diseño

- El registro `x0` está protegido por software en el testbench (inicializado a 0).
- El procesador es **single-cycle**: no hay pipeline, cada instrucción tarda exactamente 1 ciclo de reloj en completarse.
- El reset del PC es **asíncrono activo alto**: en cuanto `rst=1`, el PC vuelve a `0x00000000` sin esperar el flanco de reloj.
- La señal `PCSrc` se calcula como `(zero & Branch) | Jump`, controlando si el siguiente PC es `PC+4` o `PC+Imm`.
- El mux de writeback soporta 4 fuentes: resultado de la ALU, dato de memoria, `PC+4` (para `jal`) y cero.

---

## Prueba de simulación



---
## Autor

Ángeles Araiza García A00574806
