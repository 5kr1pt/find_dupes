# Find-LocalDuplicates.ps1 - Verificador de Arquivos Duplicados

Este é um script PowerShell projetado para encontrar e listar arquivos duplicados em um diretório local.

Sua principal característica é a capacidade de **ignorar placeholders de nuvem** (como arquivos do Google Drive ou OneDrive "Disponíveis apenas online"), focando apenas em arquivos que estão fisicamente presentes na máquina. Isso evita que o script acidentalmente baixe terabytes de dados ao tentar calcular um hash.

O script usa um método de duas etapas para eficiência:
1.  Primeiro, agrupa arquivos pelo **mesmo tamanho**.
2.  Em seguida, calcula o hash **SHA256** apenas para os arquivos desses grupos, garantindo precisão sem desperdiçar processamento.

---

## 🚀 Funcionalidades Principais

* **Busca Recursiva:** Verifica o diretório raiz e todos os seus subdiretórios.
* **Ignora Arquivos Offline:** Utiliza `[IO.FileAttributes]::Offline` para pular arquivos que são apenas placeholders de nuvem.
* **Eficiente:** Pré-filtra por tamanho antes de realizar o cálculo de hash (que é mais lento).
* **Preciso:** Usa o algoritmo SHA256 para uma comparação de hash confiável.
* **Saída Clara:** Lista os arquivos duplicados agrupados por seu hash.

---

## 📋 Como Usar

Atualmente, o script requer que o caminho seja definido diretamente no arquivo.

1.  **Clone o repositório** ou baixe o arquivo `Find-LocalDuplicates.ps1` (ou o nome que você deu a ele).
2.  **Edite o script:** Abra o arquivo `.ps1` em um editor (como VS Code, Bloco de Notas, etc.).
3.  **Altere o Caminho:** Modifique a variável `$path` na linha 1 para apontar para o diretório que você deseja verificar:
    ```powershell
    $path = 'G:\CAMINHO\DE\VERIFICACAO'
    ```
4.  **Execute:**
    * Abra um terminal PowerShell.
    * Navegue até a pasta onde o script está salvo.
    * Execute o script:
    ```powershell
    .\Find-LocalDuplicates.ps1
    ```
