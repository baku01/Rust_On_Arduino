# Rust on Arduino 🤖💡

Este é um projeto básico que pisca um LED em um Arduino usando Rust e a biblioteca [arduino-hal](https://crates.io/crates/arduino-hal). O código está configurado para ser compilado sem a biblioteca padrão (`#![no_std]`) e sem a função de entrada/saída padrão (`#![no_main]`).

## Pré-requisitos 🛠️

Certifique-se de ter o ambiente de desenvolvimento Rust configurado corretamente. Você pode encontrar instruções sobre como configurar o ambiente Rust em [rustup.rs](https://rustup.rs/).

Além disso, você precisará do `avrdude` instalado em seu sistema para fazer o upload do código para o Arduino.

## Compilação e Execução ⚙️

Para compilar o código, execute o seguinte comando no terminal:

```bash
./run.sh
```

Este script compila o código usando o Cargo (o gerenciador de pacotes Rust) e produz um arquivo binário ELF para o Arduino.

Antes de executar o código, lembre-se de adaptar o caminho do arquivo de entrada no script `run.sh`. Após ajustar o caminho.

Este script executa o `avrdude` para fazer o upload do arquivo binário para o Arduino conectado via porta serial (`/dev/ttyUSB0`). Certifique-se de que o Arduino está conectado corretamente e que a porta serial está configurada corretamente.

## Funcionamento do Código 🚀

O código principal está localizado em `src/main.rs`. Aqui está uma explicação de trechos-chave do código:

```rust
use panic_halt as _;

#[arduino_hal::entry]
fn main() -> ! {
```

Essas diretivas `use` e `#[arduino_hal::entry]` indicam que não estamos usando a biblioteca padrão do Rust e que estamos usando o `arduino_hal::entry`, um macro fornecido pela biblioteca `arduino-hal`, para definir nossa função de entrada.

```rust
    let dp = arduino_hal::Peripherals::take().unwrap();
    let pins = arduino_hal::pins!(dp);
```

Essas linhas inicializam o acesso aos periféricos e aos pinos do microcontrolador do Arduino. `Peripherals::take()` obtém uma instância única dos periféricos do microcontrolador, enquanto `pins!()` cria uma estrutura que permite acessar os pinos específicos do Arduino.

```rust
    let mut led = pins.d13.into_output();
```

Esta linha configura o pino digital 13 do Arduino como uma saída. O LED embutido no Arduino está conectado a este pino.

# Rust vs Arduino (C++) on Arduino 🤖💡

## Código em Rust

```rust
#![no_std]
#![no_main]

use panic_halt as _;

#[arduino_hal::entry]
fn main() -> ! {
    let dp = arduino_hal::Peripherals::take().unwrap();
    let pins = arduino_hal::pins!(dp);

    let mut led = pins.d13.into_output();

    loop {
        led.toggle();
        arduino_hal::delay_ms(1000);
    }
}
```

## Código em Arduino (C++)

```cpp
void setup() {
    pinMode(13, OUTPUT);
}

void loop() {
    digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(1000);               // wait for a second
    digitalWrite(13, LOW);    // turn the LED off by making the voltage LOW
    delay(1000);               // wait for a second
}
```

## Comparação

### Similaridades:
- Ambos os códigos realizam a mesma função básica: piscar um LED conectado ao pino digital 13 do Arduino.
- Ambos os códigos utilizam uma abordagem de loop infinito para alternar o estado do LED em intervalos de tempo regulares.

### Diferenças:
- O código em Rust é mais seguro em termos de memória e thread-safe, pois é compilado sem a biblioteca padrão (`#![no_std]`) e sem a função de entrada/saída padrão (`#![no_main]`). Isso é alcançado usando o `arduino_hal::entry`, um macro fornecido pela biblioteca `arduino-hal`.
- No código em C++, usamos funções específicas da linguagem Arduino, como `pinMode()` e `digitalWrite()`, para controlar os pinos do Arduino e o LED. Essas funções são parte da biblioteca do Arduino e fornecem uma abstração de hardware fácil de usar.
- O código em Rust usa a biblioteca `arduino-hal` para acessar os periféricos e pinos do Arduino, enquanto o código em C++ usa as funções padrão do Arduino.
- O código em Rust é mais verboso em termos de inicialização dos periféricos e pinos do Arduino, enquanto o código em C++ é mais conciso e direto ao ponto.

Ambos os códigos têm suas vantagens e podem ser usados dependendo das necessidades do projeto e da preferência pessoal do desenvolvedor.

---
