### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["Dynamics of Electrical Machines"]
#> title = "TL5 - Transitórios de Máquinas Elétricas"
#> description = "Guia/relatório sobre o Trabalho Laboratorial n.º 5 (TL5). Este trabalho visa estudar os regimes transitórios de máquinas de corrente contínua (MCC) e síncronas trifásicas (MST) através de ensaios específicos. Para a MCC realizam-se ensaio em vazio para determinar perdas mecânicas e magnéticas, e ensaio de desaceleração para obter parâmetros mecânicos como momento de inércia e coeficientes de atrito, permitindo estabelecer a equação mecânica fundamental para simulação. Para a MST analisa-se o comportamento transitório durante um curto-circuito trifásico aplicado ao alternador em vazio, estudo essencial para o dimensionamento adequado de equipamentos de proteção como disjuntores e relés, garantindo a segurança e integridade do sistema elétrico."
#> date = "2026-09-11"
#> layout = "layout.jlhtml"
#> image = "https://github.com/Ricardo-Luis/me-2/blob/97a15bd381dd18a6f9932993655f62d4a9c99f23/images/card/TL5.png?raw=true"
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 03d72091-391f-4858-b7f8-969e47288be9
using PlutoUI, PlutoTeachingTools, CSV , DataFrames, HTTP, Plots, EasyFit
#=
Short packages description:
 - PlutoUI.jl, to add interactivity objects to notebook
 - PlutoTeachingTools.jl, to enhance the notebook
 - CSV.jl, a CSV (Comma Separated Values) file reading and writing
 - DataFrames.jl, Data manipulation and analysis with tabular structures
 - HTTP.jl, HTTP client and server functionality for web request
 - Plots.jl, visualization interface and toolset to build graphics
 - EasyFit.jl, interface for obtaining fits of 2D data
=#

# ╔═╡ 2c8630b8-91e2-4563-814d-7d310cffb4ef
TwoColumnWideLeft(md"`TL5.jl`", md"`Last update: 11·09·2026`")

# ╔═╡ ed32cd37-3b8b-439a-9c96-ca7da5e7a061
md"""
---
$\textbf{RELATÓRIO TL5}$ 

$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Transitórios de Máquinas Elétricas}}}$
---
"""

# ╔═╡ 73edb666-0186-4298-a61d-c708c77e9010
md"""
# 1 - Introdução


## 1.1 - Objetivos

O trabalho laboratorial, TL5 - Transitórios de Máquinas Elétricas, tem os seguintes objetivos:

- Distinguir os regimes transitórios das máquinas elétricas (ME) em estudo (ME de corrente contínua e ME síncrona trifásica), examinando o comportamento e os resultados experimentais em ensaios específicos;
- Determinar os parâmetros mecânicos de uma ME a partir do ensaio de desaceleração; 
- Obter os parâmetros que caracterizam o regime dinâmico de um curto-circuito trifásico aplicado a um alternador síncrono em vazio.
"""

# ╔═╡ d41f2f9e-a0e7-4a1f-a958-cd8f5ba7ffe5
md"""
## 1.2 - Ensaios laboratoriais

Este trabalho permite uma introdução ao funcionamento dos regimes dinâmicos das ME analisadas durante as atividades laboratoriais.\
Assim, neste trabalho laboratorial é utilizado o motor de corrente contínua como exemplo para obtenção da sua equação mecânica, através dos ensaios em vazio, para determinar as perdas mecânicas, $p_{mec}$, e de desaceleração para obter os parâmetros mecânicos. A equação mecânica do motor como parte do modelo matemático da máquina é fundamental para simulação e otimização do seu desempenho, e como base para estudos mais avançados em máquinas elétricas e sistemas de controlo.\
A análise do regime transitório de um curto-circuito trifásico aplicado a um alternador síncrono é fundamental para o dimensionamento de equipamentos de proteção, como disjuntores e relés. Este estudo permite garantir que os dispositivos sejam capazes de suportar e interromper correntes de defeito elevadas, assegurando assim a integridade e a segurança do sistema elétrico onde a máquina síncrona esteja integrada.


**Máquina de corrente contínua**

- Ensaio em vazio do motor de corrente continua (utilizar excitação em derivação ou independente) para separação de perdas mecânicas e magnéticas, $p_{(mec+Fe)}$;
- Ensaio de desaceleração do motor de corrente contínua para determinação dos parâmetros mecânicos: momento de inércia, $J$, coeficiente de atrito dinâmico, $K_d$, e coeficiente de atrito estático, $K_e$.

**Máquina síncrona de polos salientes**

- Ensaio do alternador à tensão nominal em vazio, submetido a um curto-circuito trifásico.

"""

# ╔═╡ cd6d3267-4cf1-436f-aeaf-f37f48ca1eab


# ╔═╡ 58642ad2-3aeb-4c55-ac3a-0cd1cd7bfaaf
md"""
# 2 - Procedimentos de ensaios
"""

# ╔═╡ e51a2abf-e00d-4b80-aee4-9a740a8d8244
md"""
Nesta secção apresentam-se os procedimentos de ensaios, partindo dos esquemas necessários, material utilizado e a condução de trabalho relativa a cada ensaio experimental.
"""

# ╔═╡ ae2dd8d9-7774-42d9-8daa-de671c778558
md"""
## 2.1 - Esquema de ligações
"""

# ╔═╡ 684c6152-63c6-47c4-a20d-d34bf2cc033b
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:	
   raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/TL5/MotorDC_MaqSinc.drawio"
   
# Adjustable settings:
   iframe_width = 690
   iframe_height = 400
# 1 = fit diagram to iframe size (keeps aspect ratio); 0 = original diagram size
   fit = 0  

# viewer_url build   
   viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&fit=$(fit)#U" * raw_url

# HTML
   HTML("""
   <div style="text-align: center;">
       <iframe frameborder="0" 
               style="width:$(iframe_width)px; height:$(iframe_height)px; border: 1px solid #ddd;" 
               src="$(viewer_url)">
       </iframe>
   </div>
   """)
end

# ╔═╡ 2324d582-e948-40d9-a5ca-e7af0c5d9321
md"""
[^Fig_1]: Esquema de ligações para os ensaios na máquina de corrente contínua e na máquina síncrona de polos salientes.
"""

# ╔═╡ 5fdb7601-2f73-4f08-8517-668df1886c33
aside((md"""
!!! warning "Atenção"
	**Utilize o seletor para indicar qual a sua bancada de trabalho**.\
	Verifique a lista de material. Esta pode ser atualizada com base nas máquinas elétricas ensaiadas e nos equipamentos de medida utilizados. 
"""), v_offset=80)

# ╔═╡ 6161d57a-030f-4c47-8b35-41b1425146d4
md"""
## 2.2 - Material utilizado
"""

# ╔═╡ 6359c098-d334-42ac-960f-190c73695606
md"""Equipamento utilizado: $(@bind bancada Select([
		"B#2" => "Bancada n.º 2",
		"B#3" => "Bancada n.º 3",
		"B#4" => "Bancada n.º 4",
		"B#5" => "Bancada n.º 5",
		"B#CA" => "Grupo conversor CC/CA"]; default="B#CA")), do Laboratório de Máquinas Elétricas.
"""

# ╔═╡ a468e6c6-8987-41dd-adfc-27f9c37e297c
let
# ============================ Workbench n.º 2 ===================================
	if bancada=="B#2"
		md"""
		
**Máquinas elétricas**

Foram utilizadas as máquinas elétricas: motor CC e alternador síncrono 3~ de polos salientes (sem barras amortecedoras) da **bancada n.º 2**:

- Motor CC (5.5kW; 1500-2000rpm; 220V; 29A): 
Elektromotoren Werke Kaiser (fabricante) 

|   V   |   A   |   kW   |   rpm   |
|:-----:|:-----:|:------:|:-------:|
|  178  |   29  |   4.4  |   1200  |
|  220  |   29  |   5.5  |   1500  |
|  220  |   29  |   5.5  |   2000  |
|       |       |        |         |
|  220  | 0.59 ... 0.35A | (excit.) |

\
		
- Alternador síncrono trifásico (9kVA; 400V-50Hz (Y); 12A; 1500rpm):
Leroy-Somer (fabricante)

|         |      |            |       |          |     |       |      |
|:-------:|:----:|:----------:|:-----:|:--------:|:---:|:-----:|:----:|
| **kW**  |   7  |  **cos φ** |  0.8  | **Y: V** | 400 | **A** |  12  | 
| **kVA** |   9  |  **cos φ** |  0.8  | **Y: V** | 400 | **A** |  12  |
| **rpm** | 1500 |   **Ph**   |  3    |  **Hz**  |  50 |       |      |
|         |      | **Excit.** |  SEP  |   **V**  | 37.3 | **A** | 2.07 |

\

- Dínamo taquimétrico: Poli (fabricante)
  - Modelo: FRB11
  - Constante de velocidade: 20.55 mV/rpm
  - Velocidade máxima: 5000rpm

\

**Equipamento de medida**

- 1 osciloscópio digital: Rigol MSO5074 
- 1 sonda diferencial de tensão: Testec, TT - SI9001, calibre 1:100 (± 700V)
- 2 sondas de corrente de efeito de Hall: Micsig, CP2100A, calibre 0,01V/A (100A)
- 1 Ohmímetro: BK Precision, modelo 2840
- 1 multímetro (voltímetro): UNI-T, UT132C
- 1 pinça multimétrica (amperímetro): PeakTech, modelo 4350
- 1 taquímetro digital: Chauvin Arnoux, CA 25
"""

# ================================================================================
# ============================ Workbench n.º 3 ===================================		
	elseif bancada=="B#3"
		md"""
		
**Máquinas elétricas**

Foram utilizadas as máquinas elétricas: motor CC e alternador síncrono 3~ de polos salientes (sem barras amortecedoras) da **bancada n.º 3**:


- Motor CC (5.5kW; 1500-2000rpm; 220V; 29A): 
Elektromotoren Werke Kaiser (fabricante) 

|   V   |   A   |   kW   |   rpm   |
|:-----:|:-----:|:------:|:-------:|
|  178  |   29  |   4.4  |   1200  |
|  220  |   29  |   5.5  |   1500  |
|  220  |   29  |   5.5  |   2000  |
|       |       |        |         |
|  220  | 0.59 ... 0.35A | (excit.) |

\
		
- Alternador síncrono trifásico (9kVA; 400V-50Hz (Y); 12A; 1500rpm):
Leroy-Somer (fabricante)

|         |      |            |       |          |     |       |      |
|:-------:|:----:|:----------:|:-----:|:--------:|:---:|:-----:|:----:|
| **kW**  |   7  |  **cos φ** |  0.8  | **Y: V** | 400 | **A** |  12  | 
| **kVA** |   9  |  **cos φ** |  0.8  | **Y: V** | 400 | **A** |  12  |
| **rpm** | 1500 |   **Ph**   |  3    |  **Hz**  |  50 |       |      |
|         |      | **Excit.** |  SEP  |   **V**  | 42.8 | **A** | 2.38 |

\

- Dínamo taquimétrico: Poli (fabricante)
  - Modelo: FRB11
  - Constante de velocidade: 20.29 mV/rpm
  - Velocidade máxima: 5000rpm

\

**Equipamento de medida**

- 1 osciloscópio digital: Rigol MSO5074 
- 1 sonda diferencial de tensão: Testec, TT - SI9001, calibre 1:100 (± 700V)
- 2 sondas de corrente de efeito de Hall: Micsig, CP2100A, calibre 0,01V/A (100A)
- 1 Ohmímetro: BK Precision, modelo 2840
- 1 multímetro (voltímetro): UNI-T, UT132C
- 1 pinça multimétrica (amperímetro): PeakTech, modelo 4350
- 1 taquímetro digital: Chauvin Arnoux, CA 25
"""

# ================================================================================
# ============================ Workbench n.º 4 ===================================			
	elseif bancada=="B#4"
		md"""
		
**Máquinas elétricas**

Foram utilizadas as máquinas elétricas: motor CC e alternador síncrono 3~ de polos salientes (com barras amortecedoras) da **bancada n.º 4**:


- Motor CC (6.5kW; 1500-2250rpm; 220V; 35A): 
Elektromotoren Werke Kaiser (fabricante) 

|   V   |   A   |   kW   |   rpm   |
|:-----:|:-----:|:------:|:-------:|
|  220  |   35  |   6.5  |   1500  |
|  220  |   35  |   6.5  |   2250  |
|       |       |        |         |
|       | 0.54 ... 0.24A | (excit.) |

\
		
- Alternador síncrono trifásico (4.1kVA; 380V-50Hz (Y); 6.2A; 1500rpm):
Leroy-Somer (fabricante)

|         |      |            |       |          |     |       |      |
|:-------:|:----:|:----------:|:-----:|:--------:|:---:|:-----:|:----:|
| **kW**  | 3.28 |  **cos φ** |  0.8  | **Δ: V** | 220 | **A** | 10.8 | 
| **kVA** |  4.1 |  **cos φ** |  0.8  | **Y: V** | 380 | **A** | 6.2  |
| **rpm** | 1500 |   **Ph**   |  3    |  **Hz**  |  50 |       |      |
|         |      | **Excit.** |  SEP  |   **V**  | 17  | **A** |  33  |

\

- _Encoder_ com saída taquimétrica: BEI Ideacod (fabricante)
  - Modelo: NHT912596R/1800/P/3000
  - Constante de velocidade: 3.2 mV/rpm
  - Velocidade máxima: 6000rpm

\

**Equipamento de medida**

- 1 osciloscópio digital: Rigol MSO5074 
- 1 sonda diferencial de tensão: Testec, TT - SI9001, calibre 1:100 (± 700V)
- 2 sondas de corrente de efeito de Hall: Micsig, CP2100A, calibre 0,01V/A (100A)
- 1 Ohmímetro: BK Precision, modelo 2840
- 1 multímetro (voltímetro): UNI-T, UT132C
- 1 pinça multimétrica (amperímetro): PeakTech, modelo 4350
- 1 taquímetro digital: Chauvin Arnoux, CA 25
"""

# ================================================================================
# ============================ Workbench n.º 5 ===================================
	
	elseif bancada=="B#5"
		md"""
		
**Máquinas elétricas**

Foram utilizadas as máquinas elétricas: motor CC e alternador síncrono 3~ de polos salientes (com barras amortecedoras) da **bancada n.º 5**:


- Motor CC (6.5kW; 1500-2250rpm; 220V; 35A): 
Elektromotoren Werke Kaiser (fabricante) 

|   V   |   A   |   kW   |   rpm   |
|:-----:|:-----:|:------:|:-------:|
|  220  |   35  |   6.5  |   1500  |
|  220  |   35  |   6.5  |   2250  |
|       |       |        |         |
|       | 0.54 ... 0.24A | (excit.) |

\
		
- Alternador síncrono trifásico (4.1kVA; 380V-50Hz (Y); 6.2A; 1500rpm):
Leroy-Somer (fabricante)

|         |      |            |       |          |     |       |      |
|:-------:|:----:|:----------:|:-----:|:--------:|:---:|:-----:|:----:|
| **kW**  | 3.28 |  **cos φ** |  0.8  | **Δ: V** | 220 | **A** | 10.8 | 
| **kVA** |  4.1 |  **cos φ** |  0.8  | **Y: V** | 380 | **A** | 6.2  |
| **rpm** | 1500 |   **Ph**   |  3    |  **Hz**  |  50 |       |      |
|         |      | **Excit.** |  SEP  |   **V**  | 17  | **A** |  33  |

\

- Dínamo taquimétrico: oemer (fabricante)
  - Modelo: 3R 20
  - Constante de velocidade: 20.52 mV/rpm
  - Velocidade máxima: 8000rpm

\

**Equipamento de medida**

- 1 osciloscópio digital: Rigol MSO5074 
- 1 sonda diferencial de tensão: Testec, TT - SI9001, calibre 1:100 (± 700V)
- 2 sondas de corrente de efeito de Hall: Micsig, CP2100A, calibre 0,01V/A (100A)
- 1 Ohmímetro: BK Precision, modelo 2840
- 1 multímetro (voltímetro): UNI-T, UT132C
- 1 pinça multimétrica (amperímetro): PeakTech, modelo 4350
- 1 taquímetro digital: Chauvin Arnoux, CA 25
		"""

# ================================================================================
# ============================ DC-AC conversion group ============================
	elseif bancada=="B#CA"
		md"""
		
**Máquinas elétricas**

Foram utilizadas as máquinas elétricas: motor CC e alternador síncrono 3~ de polos salientes (com barras amortecedoras) do **grupo conversor CC-CA**:


- Motor CC (12.5kW; 1200-2000rpm; 220V; 63A): 
Elektromotoren Werke Kaiser (fabricante) 

|   V   |   A   |   kW   |   rpm   |
|:-----:|:-----:|:------:|:-------:|
|  220  |   63  |   15.5 |   1200  |
|  220  |   63  |   12.5 |   2000  |
|       |       |        |         |
|  250  | 0.9 ... 0.35A | (excit.) |

\
		
- Alternador síncrono trifásico (10kVA; 400V-50Hz (Y); 15.2A; 1500rpm):
Leroy-Somer (fabricante)

|         |      |            |       |          |     |       |      |
|:-------:|:----:|:----------:|:-----:|:--------:|:---:|:-----:|:----:|
| **kW**  |   8  |  **cos φ** |  0.8  | **Δ: V** | 220 | **A** | 26.2 | 
| **kVA** |  10  |  **cos φ** |  0.8  | **Y: V** | 380 | **A** | 15.2 |
| **rpm** | 1500 |   **Ph**   |  3    |  **Hz**  |  50 |       |      |
|         |      | **Excit.** |  SEP  |   **V**  | 100 | **A** | 0.50 |

\

- Dínamo taquimétrico: RADIO-ENERGIE (fabricante)
  - Modelo: REo 444
  - Constante de velocidade: 58 mV/rpm
  - Velocidade máxima: 9000rpm

\

**Equipamento de medida**

- 1 osciloscópio digital: Rigol MSO5074 
- 1 sonda diferencial de tensão: Testec, TT - SI9001, calibre 1:100 (± 700V)
- 2 sondas de corrente de efeito de Hall: Micsig, CP2100A, calibre 0,01V/A (100A)
- 1 Ohmímetro: BK Precision, modelo 2840
- 1 multímetro (voltímetro): UNI-T, UT132C
- 1 pinça multimétrica (amperímetro): PeakTech, modelo 4350
- 1 taquímetro digital: Chauvin Arnoux, CA 25

\

**Equipamento de proteção**
- Protetores auriculares 3M™ PELTOR™ H510A, redução de ruído até 27dB
"""
	end
end	

# ╔═╡ 4d4e1abb-7063-4da4-b3a8-038499a94f97


# ╔═╡ 0ac3d670-a191-49e5-9242-e06e2230d8dc
md"""
## 2.3 - Condução do trabalho
"""

# ╔═╡ b7c67c72-bf87-4e5d-8169-1fe73e977f9d
md"""
### 2.3.1 - Motor CC
### 2.3.1.2 - Ensaio em vazio para separação: $\; p_{\rm{mec+Fe}}$
"""

# ╔═╡ d015d7ea-8412-4bf3-8d4e-d8b895a5ee8f
md"""

Na literatura de máquinas elétricas este ensaio é denominado por teste de Swinburne, [^1], [^2], podendo ser executado num motor de corrente contínua de excitação separada ou de excitação derivação.

1. Montagem do ensaio experimental de acordo com o esquema de ligações, [^Fig_1];
1. Ligar o circuito de excitação. Verificar e ajustar a corrente de campo para o valor máximo $($reóstato de campo no mínimo, $R_c=0)$;
1. Proceder ao arranque do motor de forma suave, através da regulação da tensão do induzido (usando o auto-transformador + ponte de díodos trifásica de onda completa), até atingir a velocidade nominal;
1. Verificar qual a tensão do induzido necessária quando o reóstato de campo estiver no valor máximo, para manter a velocidade nominal constante durante todo o ensaio.
1. O passo anterior permite ter uma ideia dos intervalos de variação da tensão do induzido para se obter um conjunto de pelo menos $10$ leituras; 
1. Partindo de $R_c=0\; \Omega$, e velocidade nominal, registar o par de valores da tensão e corrente do induzido, $(U_a, I_a)$;
1. Próximas leituras, $(U_a, I_a)$: a cada diminuição sucessiva da tensão do induzido e aumento do reóstato de campo (para manter a velocidade do motor constante);
1. Após a última leitura, desligar a tensão do induzido e depois o circuito de excitação do motor;
1. No final ou no início da experiência laboratorial, efetuar a medição da resistência do enrolamento do induzido do motor, terminais: $(\rm{GA-HB})$.
"""

# ╔═╡ fcd5fea9-c3a3-4480-8242-75b3cce8d099


# ╔═╡ 3dc2f1ac-cdd0-460c-803f-47b6e91fc618
md"""
### 2.3.1.2 - Ensaio de desaceleração
"""

# ╔═╡ ced15987-9ff1-4214-b30d-78e3805d9212
md"""
Na literatura de máquinas elétricas este vem descrito em [^3], o procedimento experimental para a determinação do momento de inércia de uma máquina.
"""

# ╔═╡ 8359da3d-375d-4a74-a49d-adc8e4611bab
md"""
1. Montagem do ensaio experimental de acordo com o esquema de ligações, incluindo a ligação da taquigeradora a um dos canais do osciloscópio digital, [^Fig_1];
1. Ligar o circuito de excitação. Verificar e ajustar a corrente de campo para o valor máximo $($reóstato de campo no mínimo, $R_c=0)$;
1. Proceder ao arranque do motor de forma suave, através da regulação da tensão do induzido (usando o auto-transformador + ponte de díodos trifásica de onda completa), até atingir a velocidade nominal;
1. Preparar o oscilóscópio digital para registar a evolução temporal da velocidade, ajustando ganhos horizontal e vertical;
1. Desligar a tensão do induzido e visualizar a curva de desaceleração no osciloscópio. Gravar os registos de imagem e dados CSV do osciloscópio numa _pen drive_ USB;
1. Desligar o circuito de excitação do motor.
"""

# ╔═╡ 3be5a557-c355-466f-b439-e31d86823593


# ╔═╡ d496fd8e-111c-4f94-bef4-37d08010e8b0
md"""
### 2.3.2 - Ensaio de curto-circuito trifásico do alternador síncrono em vazio
"""

# ╔═╡ 2a460ffd-8507-4b9e-b367-6c6448329a9e
md"""
1. Montagem do ensaio experimental de acordo com o esquema de ligações, incluindo as ligações ao oscilóscópio (CH1: corrente do estator; CH2: corrente de excitação), [^Fig_2];
1. Ligar o motor de corrente contínua e ajustar para a velocidade nominal do alternador;
1. Ajustar a corrente de campo do alternador para obter a tensão nominal em vazio;
1. Preparar o oscilóscópio digital para registar a evolução das correntes durante o ensaio de curto-circuito, ajustando ganhos horizontal e vertical e janela de captura;
1. Proceder à manobra de curto-circuito através do disjuntor/contactor considerado na montagem para esse efeito;
1. Visualizar o ensaio no osciloscópio. Gravar os registos de imagem e dados CSV do osciloscópio numa _pen drive_ USB;
1. Desfazer o curto-circuito;
1. Desligar o circuito de excitação do alternador;
1. Desligar o motor de corrente contínua.
"""

# ╔═╡ 7c2f9a07-bc0f-49a9-8fab-89299d0098f1
aside((md"""
!!! warning "Atenção"
	**Substituir pelos seus resultados**:
	   - tensão em vazio
	   - corrente do induzido
	   - Resistência do induzido
"""), v_offset=215)

# ╔═╡ 663dee2f-75f6-4923-8c21-fc9daac8d095
md"""
# 3 - Resultados experimentais
"""

# ╔═╡ a8740a11-78f2-418f-94fe-b98fde0ef992
md"""
## 3.1 - Motor CC
"""

# ╔═╡ d77d021c-7d48-43ce-8ea4-4e2571bd1491
md"""
### 3.1.1 - Ensaio em vazio para separação: $\; p_{\rm{mec+Fe}}$
"""

# ╔═╡ cdbe0d0c-ce72-405f-a80a-a52df24c6c03
U = [220, 210, 200, 190, 180, 170, 160, 151, 140, 130, 121, 110, 100, 92] #voltage, V

# ╔═╡ 66a50cc3-7bea-45d0-908f-b12c529e82f2
Ia = [2720, 2730, 2740, 2780, 2816, 2870, 3036, 3080, 3180, 3353, 3492, 3730, 4010, 4335] #current, mA 

# ╔═╡ 5098a9ca-89f7-4f6d-8bfc-9eb18110e176
data1 = (select=[U,Ia], DataFrame)

# ╔═╡ 4aaf3368-5614-4aef-ae4a-400efcf74895
md"""
Resistência do induzido (Ω):
"""

# ╔═╡ 881564ee-5219-451f-8346-658f0aa4972f
Rᵢ = 0.834

# ╔═╡ e9dd8aa4-5377-4877-9569-0720cda2504a
md"""
As perdas mecânicas e do ferro,  $p_{(mec+Fe)}$, do motor de excitação separada em vazio são dadas por:

$p_{(mec+Fe)} = U \; I_a - R_a \; I_a^2$
"""

# ╔═╡ c7773506-b308-431d-adb2-0c55c72e8879
pₗₒₛₛₑₛ = U .* (Ia/1000) .- Rᵢ * (Ia/1000).^2

# ╔═╡ fb684796-9a16-41f2-bfe4-a4cb9160c265
scatter(U, pₗₒₛₛₑₛ, xaxis=[0,240], yaxis=[0, 600], xlabel="Tensão (V)", 
					ylabel="Perdas mecânicas e do ferro (W)", label=:none)

# ╔═╡ 8e400126-63be-41db-b264-f3bbc7cda806
aside((md"""
!!! warning "Atenção"
	**Neste campo deve substituir estes dados CSV pelos seus.**\
	Sugere-se que partilhe o ficheiro CSV a partir da sua conta Microsoft\Onedrive do ISEL. Seguir as notas de modificação do _link_ URL para forçar o _download_. 
"""), v_offset=115)

# ╔═╡ 07fe612f-3742-4d1b-bc90-c1fdf8bab30f
md"""
### 3.1.2 - Ensaio de desaceleração
"""

# ╔═╡ b6805114-cac1-4866-ba9e-312946b7feb4
md"""
Acesso ao ficheiro de dados (CSV) do osciloscópio:
"""

# ╔═╡ a0e94996-dc43-4967-bda2-7cc9498a1eeb
# Load CSV data from OneDrive SharePoint
# Required packages: CSV.jl, DataFrames.jl, HTTP.jl

# OneDrive direct download URL
# Note: Replace :x: with :u: and add "&download=1" at end to force direct download

url_file = "https://iplx-my.sharepoint.com/:u:/g/personal/ricardo_deea_isel_ipl_pt/ESO1thL-X1BOtQWpthQThsgBq0RNFI3YBNQgA4LrHV16Zw?e=LWnl9y&download=1";

# ╔═╡ bb9916c2-47ee-403b-8382-ef41fbca57c3
# Download CSV file from OneDrive
CSV_Mcc = HTTP.get(url_file);

# ╔═╡ 058f892b-1705-4821-bd6c-813fc6f30a78
# Parse CSV data into DataFrame
data_Mcc = CSV.read(IOBuffer(CSV_Mcc.body), DataFrame) # Scope deceleration test data

# ╔═╡ 4193cb25-de59-49bb-a329-4c173ca18f8e
tempo = data_Mcc[!,1]; # extractaing time data

# ╔═╡ 1ba364ee-8920-4a9f-ad36-29d882f560eb
CH1_Mcc = data_Mcc[!,2]; # extractaing CH1 voltages data

# ╔═╡ 488a36a0-fef6-475d-9f69-56801f0059f7


# ╔═╡ fe4db7cb-f5fb-48d5-a26c-241a153ac55d
md"""
#### 3.1.2.1 - Decimação de dados do osciloscópio
"""

# ╔═╡ e8dece0d-9a75-4e67-80ff-118603691c1e
md"""
A decimação é uma técnica para reduzir a quantidade de dados mantendo apenas uma amostra de pontos regularmente espaçados. Por exemplo, se temos 1 milhão de pontos e aplicamos uma decimação de fator 10, ficamos apenas com 100.000 pontos (1 em cada 10).
Porquê usar decimação?

- **Velocidade:** Menos pontos = cálculos mais rápidos
- **Memória:** Reduz o uso da memória RAM do computador
- **Visualização:** Gráficos mais fluidos
"""

# ╔═╡ 22598e72-fd83-4556-8a83-d1f32b919585
md""" **Decimação?** $(@bind dec_Mcc Select([
		"original" => "Dados originais (Sem decimação)",
		"10x" => "Decimação 10x (1 em cada 10 pontos)",
		"100x" => "Decimação 100x (1 em cada 100 pontos)",
		"1000x" => "Decimação 1000x (1 em cada 1000 pontos)",
		]; default="100x"))
"""

# ╔═╡ 3ea09b6d-e0a3-44fd-a0fa-99d4c6933321
# Data reduction for oscilloscope data
# Choose reduction strategy based on your analysis needs:
if dec_Mcc == "original"
	data_cc = data_Mcc
elseif dec_Mcc == "10x"
	# Option 1: 10 μs timestep (10x reduction)
	data_5_cc_us = data_Mcc[1:10:end, :]
	data_cc = data_5_cc_us
elseif dec_Mcc == "100x"	
	# Option 2: 100 μs timestep (100x reduction)
	data_50_cc_us = data_Mcc[1:100:end, :]
	data_cc = data_50_cc_us
elseif dec_Mcc == "1000x"
	# Option 3: 1 ms timestep (1000x reduction)
	data_500_cc_us = data_Mcc[1:1000:end, :]
	data_cc = data_500_cc_us
end

# ╔═╡ af146314-12f3-4e2c-a8cd-86e9f487e012
begin
	t_cc=data_cc[!,1]
	ch1_cc=data_cc[!,2]
	t_cc, ch1_cc 			# data of each column: time (s), CH1 (V)
end

# ╔═╡ 39bd6233-e7ea-4b7d-bcb3-9538e6229de0
aside((md"""
!!! warning "Atenção"
	**Certifique-se do ganho da sonda diferencial de tensão e do fator de escala definido no osciloscópio, ajustando-os se necessário**. 
"""), v_offset=115)

# ╔═╡ c447185a-f13d-4d11-8233-1f572db1f917
md"""
#### 3.1.2.2 -- Gráfico de desaceleração
"""

# ╔═╡ a8708162-de5d-4681-a23c-1c1019e9e3a5
md"""
**Transposição para escala de velocidade (V -> rpm):**
"""

# ╔═╡ f917bfd2-d302-4845-88b3-fbf2127c054a
md"""
Ganho da sonda diferencial de tensão:
"""

# ╔═╡ ca9b9f44-bd2b-4baa-911c-ed2f09c009a0
Volt_probe = 1/100  	# 1V -> 100V

# ╔═╡ 9c9af988-29f2-4bc6-b03f-56e694c27de3
md"""
Ganho do dínamo taquimétrico (V/rpm):
"""

# ╔═╡ ba7bd9cf-44b4-40b5-a1d3-159f599e998f
begin

# ============================ Workbench n.º 2 ===================================
	
	if bancada=="B#2"

		Tacho_gain = 20.55/1000 # V/rpm

# ================================================================================
# ============================ Workbench n.º 3 ===================================
	
	elseif bancada=="B#3"

		Tacho_gain = 20.29/1000 # V/rpm

# ================================================================================
# ============================ Workbench n.º 4 ===================================
	
	elseif bancada=="B#4"

		Tacho_gain = 3.20/1000 # V/rpm
		
# ================================================================================
# ============================ Workbench n.º 5 ===================================
	
	elseif bancada=="B#5"

		Tacho_gain = 20.52/1000 # V/rpm

# ================================================================================
# ============================ DC-AC conversion group ============================
	
	elseif bancada=="B#CA"

		Tacho_gain = 58.00/1000 # V/rpm

# ================================================================================

	end
	Text("Tacho_gain = $(round(Tacho_gain, digits=5)) V/rpm")
end

# ╔═╡ d41137aa-61f1-4efe-b3dd-6cba76026ecc


# ╔═╡ 43749024-ed93-41b0-9f62-e458e2abcfd5
velocidade = ch1_cc / Tacho_gain

# ╔═╡ 0d3b2041-9633-44bf-a09f-0d0626205826
md"""
Ajustar o instante t=0 para o início do ensaio: $$\Delta t (s)=$$ $(@bind Δt_cc Slider(0:0.01:6; default=0, show_value=true)) 
"""

# ╔═╡ 169ab7ab-14b1-4997-889c-6e7e1ff80147
plot(t_cc.-Δt_cc, velocidade, ylabel="Velocidade (rpm)", xlabel="Tempo (s)", 		 							  label=:none)

# ╔═╡ 85f60edb-7ed6-4684-a332-488874658a59
aside((md"""
!!! warning "Atenção"
	**Neste campo deve substituir estes dados CSV pelos seus.**\
	Sugere-se que partilhe o ficheiro CSV a partir da sua conta Microsoft\Onedrive do ISEL. Seguir as notas de modificação do _link_ URL para forçar o _download_. 
"""), v_offset=155)

# ╔═╡ 43a89c9e-85a1-49f9-852f-b02fed01dd0c
md"""
## 3.2 -- Transitório de curto-circuito no alternador
"""

# ╔═╡ 3d129e5b-cb06-47b0-9490-f8391a9d120c
md"""
Acesso ao ficheiro de dados (CSV):
"""

# ╔═╡ df3ba2f9-aaf4-4579-89ad-69113ce5dc8e
# Load CSV data from OneDrive SharePoint
# Required packages: CSV.jl, DataFrames.jl, HTTP.jl

# OneDrive SharePoint direct download URL
# Note: Replace :x: with :u: and add "&download=1" at end to force direct download

	#url = "https://iplx-my.sharepoint.com/:u:/g/personal/ricardo_deea_isel_ipl_pt/EX4wNdFibGtPpjvZv8aKdT4BI5J_4fNc-sLPs26zLX-6GQ?e=Av0I3C&download=1";

# other tests:
	url = "https://iplx-my.sharepoint.com/:u:/g/personal/ricardo_deea_isel_ipl_pt/EdQV22RuIjZGuoDxnmAT5JIBC6EtmZQISDs5VH-rp6UP2Q?e=g6IBOr&download=1";
	
	#url = "https://iplx-my.sharepoint.com/:u:/g/personal/ricardo_deea_isel_ipl_pt/EZ52PneT0DVEqTXpbTF7lWAB8-oEGfQBzx8wALJYx2e85g?e=38JokM&download=1";

# ╔═╡ a9c02270-4c71-490a-928f-d465e8764576
# Download CSV file from OneDrive
CSV_SC = HTTP.get(url);

# ╔═╡ 3ce227cc-37a2-4cd0-be06-d90e1cb23e0b
# Parse CSV data into DataFrame
data_osc_SC = CSV.read(IOBuffer(CSV_SC.body), DataFrame) # Scope short-circuit data

# ╔═╡ 8a565e25-34f2-459d-819f-c88cbc6d9c15


# ╔═╡ 1660096b-1f6f-426c-8a4b-5ab59e17bc10
md"""
### 3.2.1 -- Decimação de dados do osciloscópio
"""

# ╔═╡ d365359b-6759-44c3-bf09-c35dadd62b29
md"""
A decimação é uma técnica para reduzir a quantidade de dados mantendo apenas uma amostra de pontos regularmente espaçados. Por exemplo, se temos 1 milhão de pontos e aplicamos uma decimação de fator 10, ficamos apenas com 100.000 pontos (1 em cada 10).
Porquê usar decimação?

- **Velocidade:** Menos pontos = cálculos mais rápidos
- **Memória:** Reduz o uso da memória RAM do computador
- **Visualização:** Gráficos mais fluidos
"""

# ╔═╡ 14584720-6811-4774-9fc0-54ce524c89c4
begin
	# Calculate original timestep from time column
	# Use points far apart to avoid rounding issues
	time_diff = data_osc_SC[1000, "Time(s)"] - data_osc_SC[1, "Time(s)"]  # Use points further apart
	original_timestep = time_diff / 999  # Divide by number of intervals
	md"""Original _time step_: $(round(original_timestep*1e6, digits=2)) μs"""
end

# ╔═╡ 6c48f0d5-70cb-4cfa-80a2-2a3f2f5e84b1
begin
	# Calculate original timestep from time column
	# Use points far apart to avoid rounding issues
	time_diff_Mcc = data_Mcc[1000, "Time(s)"] - data_Mcc[1, "Time(s)"]  # Use points further apart
	original_timestep_Mcc = time_diff_Mcc / 999  # Divide by number of intervals
	md"""Original _time step_: $(round(original_timestep*1e6, digits=2)) μs"""
end

# ╔═╡ 258ecb33-9396-4d9c-afe4-871fd165b014


# ╔═╡ 866265b0-4c95-41ee-ad33-828868cf7fa9
md""" Decimação? $(@bind decSC Select([
		"original" => "Dados originais (Sem decimação)",
		"10x" => "Decimação 10x (1 em cada 10 pontos)",
		"100x" => "Decimação 100x (1 em cada 100 pontos)",
		"1000x" => "Decimação 1000x (1 em cada 1000 pontos)",
		]; default="100x"))
"""

# ╔═╡ 3355f4d0-fc6f-4b2c-88a3-79e2a3f93b60
# Data reduction for oscilloscope data
# Choose reduction strategy based on your analysis needs:

if decSC == "original"
	data_SC = data_osc_SC
elseif decSC == "10x"
	# Option 1: 10 μs timestep (10x reduction)
	data_5us = data_osc_SC[1:10:end, :]
	data_SC = data_5us
elseif decSC == "100x"	
	# Option 2: 100 μs timestep (100x reduction)
	data_50us = data_osc_SC[1:100:end, :]
	data_SC = data_50us
elseif decSC == "1000x"
	# Option 3: 1 ms timestep (1000x reduction)
	data_500us = data_osc_SC[1:1000:end, :]
	data_SC = data_500us
end

# ╔═╡ 7d7befd2-5c57-401e-aa11-c922b301a6cf
begin
	t_SC=data_SC[!,1]
	ch1_SC=data_SC[!,2]
	ch2_SC=data_SC[!,3]
	t_SC, ch1_SC, ch2_SC 	# data of each column: time (s), CH1 (V), CH2 (V)
end

# ╔═╡ 2c36c4b8-6fd9-4c7e-b448-b723c9845fbd
aside((md"""
!!! warning "Atenção"
	**Verifique o ganho das sondas de corrente, ganhos verticais e fator de escala no osciloscópio, adequando a conversão de unidades se necessário**. 
"""), v_offset=115)

# ╔═╡ e007c3d9-19d6-4184-8389-8da9e9c43f6f
md"""
### 3.2.2 -- Gráfico temporal das correntes
"""

# ╔═╡ 72d27ac6-ada4-42ed-8639-a5cfdba36283
md"""
Ganho das sondas de corrente de efeito de hall:
"""

# ╔═╡ 3f20fbab-1649-4e64-ad67-82e68e9995ca
clamp_G= 10e-3; #V/A

# ╔═╡ 7f3d23eb-66c6-4bdd-a777-87f165464b49
md"""
Transposição dos dados selecionados do oscislocópio para valores de corrente (CH1 e CH2):
"""

# ╔═╡ fb5393a1-fca2-4512-bf78-1a36d61f99f5
i₁ = ch1_SC / clamp_G;  # stator line current during the short-circuit, A

# ╔═╡ 3ade6db8-8f2b-4de2-b981-038fe785d091
i₂ = ch2_SC / clamp_G;  # rotor current during the short-circuit test, A

# ╔═╡ 425b6829-9b2f-4fdd-be67-aeed6daade64


# ╔═╡ b37b67e2-b6c8-40d4-8a2c-0e67b4f9baa4
md"""
Ajustar o instante t=0 para o início do curto-circuito: $$\Delta t (s)=$$ $(@bind Δt_SC Slider(0:0.0001:0.02; default=0.011, show_value=true)) 
"""

# ╔═╡ 168fcba2-8cdb-4265-97b2-8e5911b06867
begin
	P1=plot(t_SC.+Δt_SC, i₁, xaxis=[-0.05,0.46], yaxis=[-120, 120], 
			 				   ylabel="Corrente estator (A)", xlabel="Tempo (s)", 						   label="CH1: Estator")
	
	P2=plot(t_SC.+Δt_SC, i₂, label="CH2: Rotor", 
					  ylabel="Corrente excitação (A)", xlabel="Tempo (s)")
	
	plot(P1, P2, layout = (2, 1))
end

# ╔═╡ cf19d614-6eef-423d-8844-6c845dcfa352


# ╔═╡ 2f25d04e-f1d4-413d-88fc-ccc005aabf06
md"""
# 4 -- Análise de resultados
"""

# ╔═╡ e4b18448-f22c-469a-9ebf-2b9ebeaae1e5
md"""
## 4.1 -- Separação $\; p_{mec+Fe}$ 
"""

# ╔═╡ d1b64d93-0b69-4e5f-b67c-5553149f5e9c


# ╔═╡ fc8898a7-0a7a-4885-baec-3b8be4b7287a
md"""
### 4.1.1 -- Cálculos auxiliares
"""

# ╔═╡ 5a1b9117-e6d3-4173-8089-0c506beaba89
md"""
Linha de tendência para as $p_{mec+Fe}$:
"""

# ╔═╡ 0d975012-eeeb-4e0c-ae69-caf8b75ffca0
p_fit = fitexp(U, pₗₒₛₛₑₛ, n=1)

# ╔═╡ c170e12d-1c24-4de5-84ae-d17f34429b73
md"""
Extrapolação das $p_{mec+Fe}$ para tensões abaixo do mínimo atingido em ensaio:
"""

# ╔═╡ 7b8a8aaa-de42-49ca-ac85-932e15f7267a
ΔU = 0:2:last(U)

# ╔═╡ c9cbbbbe-4094-4f40-9870-8743051b7918
p_curve = p_fit.(ΔU)

# ╔═╡ 270fa2d8-052c-4723-8abe-8c4a405c09fd
begin
	scatter(U, pₗₒₛₛₑₛ, xrange=[0,250], yrange=[0,600], title="Separação de perdas mecânicas e magnéticas", label="pontos de ensaio, \$p_{mec+Fe}\$", ylabel="\$p_{mec+Fe}\$, (W)", xlabel="\$U\$, (V)", legend=:bottomleft)
	plot!(p_fit.x, p_fit.y, lw=2, label="linha de tendência, \$p_{mec+Fe}\$")
	plot!(ΔU, p_curve, lw=2, label="extrapolação até: \$U =\$ [$(last(U))...0] V")
	hline!([p_curve[1]], lw=2, ls=:dash, lc=:black, label="\$p_{mec} =\$ $(round(p_curve[1], digits=1)) W")
end

# ╔═╡ 9630dc3a-f47c-4837-b5bf-83f877f0f86a


# ╔═╡ 14f8ffdb-f860-47d0-bbba-aa212338feea
md"""
### 4.1.2 -- $\; p_{mec}\;$, (W)
"""

# ╔═╡ 77c311bb-a653-4f3d-a2d3-a214346bf2fe
pᵐᵉᶜ = round(p_curve[1], digits=1)

# ╔═╡ 3fbd3f6e-6a41-4218-9eef-2f83a15f2a58


# ╔═╡ e8d9674b-2805-49f9-ad69-8c53e43a6788
md"""
## 4.2 -- Determinação dos parâmetros mecânicos
"""

# ╔═╡ 7973d2bd-9da2-4207-a312-05c96821ffaf
md"""
Modelo teórico:


$$\omega(t) = \left(\omega_0 + \dfrac{K_e}{K_d}\right) e^{-\frac{K_d}{J}t} - \dfrac{K_e}{K_d}$$
"""

# ╔═╡ 53e373f3-1cfd-49c5-ad0c-409c1e9bb6f1
time=0.0:1e-3:16.8; 		# simulation time range

# ╔═╡ 580feaab-480a-40ee-871c-fa6fd8d66e7b
ω₀ = 1500*2*π/60;  			# initial speed, rad/s

# ╔═╡ 029b40b9-dbec-4123-88c1-2eb34e842a79


# ╔═╡ d9c5c3b6-1879-4dd5-b4c0-6ba182883577
md"""
$\textbf{Parâmetros mecânicos}$

| $J\,, \;\rm{kg·m^2}$ $$\quad$$ | $$\quad$$ $K_d\,, \;\rm{Nm}/\rm{rad·s}^{-1}$ $$\quad$$ | $$K_e\,, \;\rm{Nm}$$ |
|:--:|:--:|:--:|
| $(@bind J Slider(0:1e-3:0.4; default=0.127, show_value=true)) | $$\quad$$ $(@bind Kd Slider(0:1e-6:0.1; default=0.007836, show_value=true)) $$\quad$$ | $(@bind Ke Slider(0:1e-5:1; default=0.77, show_value=true)) |

"""

# ╔═╡ 18c70d80-e5a1-4723-a5c4-abedb813a1bd
ω = (ω₀ + Ke/Kd ) * exp.(-(Kd/J)*time) .- (Ke/Kd) 		# speed, rad/s

# ╔═╡ d297b3cc-bcf8-4ee3-8932-6a5a071a3830
n = ω * 60/(2*π) 										# speed, rpm

# ╔═╡ fda4d4b4-c824-4f27-81e8-80f323643be9
begin
	plot(t_cc.-Δt_cc, velocidade, ylabel="Velocidade (rpm)", xlabel="Tempo (s)", 								  label="osciloscópio") 
	plot!(time, n, lw=2, label="teórico")	
end

# ╔═╡ 7276a59b-8d1e-4cd5-9aaa-827688769bdd


# ╔═╡ 6af3525f-4738-453d-99ab-e492fc015315
md"""
## 4.2 -- Curto-circuito 3~ do alternador
"""

# ╔═╡ cc784ba6-ab5a-4e5d-941b-6eab7a802573
md"""
O regime dinâmico da corrente de curto-circuito de um alternador síncrono é caracterizado por duas parcelas: uma parcela de corrente alternada (CA) e outra parcela de corrente contínua (CC).
"""

# ╔═╡ eb99b716-1cee-456f-ba52-90e259325870


# ╔═╡ 744f81be-d3d2-4de4-904d-b68f3c66348f
md"""
### 4.2.1 -- Componente CA
"""

# ╔═╡ d0aa166a-3483-4a00-baa0-d1851ad5b9e0
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""
o modelo matemático aproximado da evolução temporal da componente CA da corrente de curto-circuito de uma das fases para o alternador de polos salientes com barras amortecedoras vem dado por:
"""
	
	elseif bancada=="B#2" || bancada=="B#3"
		
		md"""
o modelo matemático aproximado da evolução temporal da componente CA da corrente de curto-circuito de uma das fases para o alternador de polos salientes sem barras amortecedoras vem dado por:
"""
	end
end

# ╔═╡ e8d4090a-d1a4-44e8-ba05-a71bac47b128
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""
$$i_k^{\text{ac}}(t) = \sqrt{2} E_0 \left[ \left( \frac{1}{X_d''} - \frac{1}{X_d'} \right) e^{-\frac{t}{T_d''}} + \left( \frac{1}{X_d'} - \frac{1}{X_d} \right) e^{-\frac{t}{T_d'}} + \frac{1}{X_d} \right] \sin\left( \omega t + \alpha + \varphi + \theta_k \right)$$
"""
		
	elseif bancada=="B#2" || bancada=="B#3"
				md"""
$$i_k^{\text{ac}}(t) = \sqrt{2} E_0 \left[ \left( \frac{1}{X_d'} - \frac{1}{X_d} \right) e^{-\frac{t}{T_d'}} + \frac{1}{X_d} \right] \sin\left( \omega t + \alpha + \varphi + \theta_k \right)$$
"""
	end
end

# ╔═╡ 09ed7123-dceb-451c-8007-f3fef2ae71b9
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""
Expandindo a expressão anterior verificam-se as parcelas dos períodos: subtransitório, transitório e estacionário. Sendo que apenas as máquinas síncronas com barras amortecedoras têm período subtransitório caracterizado pelos parâmetros: $(X_d''\;;\; T_d'')$. 
"""
	
	elseif bancada=="B#2" || bancada=="B#3"
				md"""
Expandindo a expressão anterior verificam-se as parcelas dos períodos transitório e estacionário. Sendo que apenas as máquinas síncronas com barras amortecedoras têm período subtransitório caracterizado pelos parâmetros: $(X_d''\;;\; T_d'')$. 
"""
	end
end

# ╔═╡ b76a8e9f-6c36-428b-9026-4c3418c22661
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""
$$i_k^{\text{ac}}(t) = \underbrace{\left(\frac{\sqrt{2} E_0}{X_d''} - \frac{\sqrt{2} E_0}{X_d'}\right) e^{-\frac{t}{T_d''}} \sin\left(\omega t + \alpha + \varphi + \theta_k\right)}_{\textbf{período subtransitório}} \: + \: \underbrace{\left(\frac{\sqrt{2} E_0}{X_d'} - \frac{\sqrt{2} E_0}{X_d}\right) e^{-\frac{t}{T_d'}} \sin\left(\omega t + \alpha + \varphi + \theta_k\right)}_{\textbf{período transitório}} \: + \: \underbrace{\frac{\sqrt{2} E_0}{X_d} \sin\left(\omega t + \alpha + \varphi + \theta_k\right)}_{\textbf{período estacionário}}$$
"""

		elseif bancada=="B#2" || bancada=="B#3"

		md"""
$$i_k^{\text{ac}}(t) = \underbrace{\left(\frac{\sqrt{2} E_0}{X_d'} - \frac{\sqrt{2} E_0}{X_d}\right) e^{-\frac{t}{T_d'}} \sin\left(\omega t + \alpha + \varphi + \theta_k\right)}_{\textbf{período transitório}} \: + \: \underbrace{\frac{\sqrt{2} E_0}{X_d} \sin\left(\omega t + \alpha + \varphi + \theta_k\right)}_{\textbf{período estacionário}}$$
"""
	end
end

# ╔═╡ d744b733-4a46-4205-ba52-729a77287f5a
md"""
Computacionalmente, vem:
"""

# ╔═╡ 23d66072-6000-4e23-85e1-546310bdff73
t = 0.0:0.001:0.45;

# ╔═╡ 89bbcfcb-cd64-430c-a27c-d9196bd6a89f
E₀=400/√3; f=50;

# ╔═╡ 771d170b-a71c-44ae-980b-101f9dca5bc4


# ╔═╡ 1b43458f-e1a0-4f6b-aee5-bb845e678831
md"""
### 4.2.2 -- Componente CC
"""

# ╔═╡ 2ddd9860-3743-4289-abbc-4441f2e65d76
md"""
A evolução temporal da componente CC da corrente de curto-circuito, vem dada por:
"""

# ╔═╡ 42a5e605-cfe0-4fea-88a3-947b415b916b
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""
$i_k^{\text{dc}}(t) = \sqrt{2} \frac{E_0}{X_d''}
\sin\left( \alpha + \varphi + \theta_k \right) e^{-\frac{t}{T_a}}$
"""

		
	elseif bancada=="B#2" || bancada=="B#3"

		md"""
$i_k^{\text{dc}}(t) = \sqrt{2} \frac{E_0}{X_d'}
\sin\left( \alpha + \varphi + \theta_k \right) e^{-\frac{t}{T_a}}$
"""
	end
end		

# ╔═╡ aed0bfbc-f8e9-466c-a0cb-2ed38f0e6af5


# ╔═╡ 73f98aff-0780-446a-a1bf-9c275a6dd0e6
md"""
### 4.2.3 -- Modelo teórico
"""

# ╔═╡ e55c00d3-cf2c-49ff-a9af-1d22d5b16c09
md"""
O modelo teórico que permite a simulação do curto-circuito trifásico de um alternador em vazio $i_k(t)$, vem dado pela soma das componentes CA e CC:

$i_k(t) = i_k^{\text{ac}}(t) + i_k^{\text{dc}}(t)$
"""

# ╔═╡ ed0de60c-de58-4f40-89dd-77e100854325


# ╔═╡ a7340aeb-76bc-4819-9cbb-24547d29a3bf
md"""
### 4.2.4 -- 💻 Determinação das reatâncias e constantes de tempo
"""

# ╔═╡ 5d0d7d02-4695-4cb6-93f6-8aa57e2e2b88
begin
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""

| $\qquad$ Reatâncias síncronas $(\Omega)\qquad$ | $\qquad$ Constantes de tempo $(\rm{s})\qquad$ | 
|:---|:---|
| $$\quad X_d^{''}$$ $(@bind Xd2 Slider(0.1:0.01:100.0; default=2.7, show_value=true)) | $$\quad T_d^{''}$$ $(@bind Td2 Slider(1e-5:1e-4:1e-1; default=20e-3, show_value=true)) |
| $$\quad X_d^{'}$$ $(@bind Xd1 Slider(0.1:0.01:40.0; default=3.49, show_value=true))| $$\quad T_d^{'}$$ $(@bind Td1 Slider(1e-4:1e-4:10e-1; default=0.05, show_value=true)) | 
| $$\quad X_d$$ $(@bind Xd Slider(1:1:350.0; default=19, show_value=true)) | $$\quad T_a$$ $(@bind Tₐ Slider(1e-4:0.1e-3:20e-1; default=0.1e-3, show_value=true)) |

| | |
|:---:|:---:|
| fase, $$\theta =$$ $(@bind θ Select([0 => "fase 1: 0°", -2π/3 => "fase 2: -120°", 2π/3 => "fase 3: +120°"])) $$\degree$$ | $$\quad$$ **ângulo de falha**, $$\alpha (\degree)=$$ $(@bind α Slider(-360:0.1:360.0, default=-89, show_value=true)) |

"""

	elseif bancada=="B#2" || bancada=="B#3"

				md"""

| $\qquad$ Reatâncias síncronas $(\Omega)\qquad$ | $\qquad$ Constantes de tempo $(\rm{s})\qquad$ | 
|:---|:---|
| $$\quad X_d^{'}$$ $(@bind Xd1 Slider(0.1:0.01:40.0; default=1, show_value=true))| $$\quad T_d^{'}$$ $(@bind Td1 Slider(1e-4:1e-4:10e-1; default=14e-3, show_value=true)) | 
| $$\quad X_d$$ $(@bind Xd Slider(1:1:350.0; default=19, show_value=true)) | $$\quad T_a$$ $(@bind Tₐ Slider(1e-4:0.1e-3:10e-1; default=0.1e-3, show_value=true)) |

| | |
|:---:|:---:|
| fase, $$\theta =$$ $(@bind θ Select([0 => "fase 1: 0°", -2π/3 => "fase 2: -120°", 2π/3 => "fase 3: +120°"])) $$\degree$$ | $$\quad$$ **ângulo de falha**, $$\alpha (\degree)=$$ $(@bind α Slider(-360:0.1:360.0, default=-90.5, show_value=true)) |

"""
		
	end
end

# ╔═╡ 14eeae09-0570-4fb5-a320-cbf8dca52f4b
begin
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		iᵃᶜ = √2*E₀*((1/Xd2-1/Xd1)*exp.(-t/Td2) .+ (1/Xd1-1/Xd)*exp.(-t/Td1) .+ 1/Xd).*sin.(2π*f*t .+ deg2rad(α) .- π/2 .+ θ)

	
	elseif bancada=="B#2" || bancada=="B#3"

		iᵃᶜ = √2*E₀*((1/Xd1-1/Xd)*exp.(-t/Td1) .+ 1/Xd).*sin.(2π*f*t .+ deg2rad(α) .- π/2 .+ θ)

	end
end

# ╔═╡ a275790e-6310-4151-a6db-f67c79b94766
begin
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		iᵈᶜ = √2*(E₀/Xd2)*sin(deg2rad(α) - π/2 + θ) .* exp.(-t/Tₐ)
		
	
	elseif bancada=="B#2" || bancada=="B#3"
		
		iᵈᶜ = √2*(E₀/Xd1)*sin(deg2rad(α) - π/2 + θ) .* exp.(-t/Tₐ)

	end
end

# ╔═╡ c36c0a70-4159-4b96-8d81-463fd0a214cc
i = iᵃᶜ + iᵈᶜ

# ╔═╡ 294e716b-31a0-4c27-8d9f-b1fe16c8debd
begin
	plot(t_SC.+0.011, i₁, xaxis=[-0.05,0.46], yaxis=[-120, 120], 
		 				  ylabel="Corrente estator (A)", xlabel="Tempo (s)", 		  				  label="Osciloscópio")
	plot!(t, i, label="Modelo teórico")
end

# ╔═╡ bc17b1d4-3fef-4e50-9527-74497fd925a7


# ╔═╡ a477ab78-ce11-4ce5-85b5-df7b18c48e92
md"""
### 4.2.5 -- Correntes de curto-circuito
"""

# ╔═╡ 277aa9c5-b50d-45e8-9a1f-309d0190b9cc
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""
Obtenção das correntes máximas $I'', I', I$: 

$I'' = \frac{\sqrt2E_0}{X''_d} \qquad;\qquad I' = \frac{\sqrt2E_0}{X'_d} \qquad;\qquad
I = \frac{\sqrt2E_0}{X_d}$
"""

	elseif bancada=="B#2" || bancada=="B#3"
		
		md"""
Obtenção das correntes máximas $I', I$: 

$I' = \frac{\sqrt2E_0}{X'_d} \qquad;\qquad I = \frac{\sqrt2E_0}{X_d}$
"""

	end
end		

# ╔═╡ cacc04e1-05ea-4537-bdba-76375f000277
begin
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		I = √2*E₀/Xd
		I = round(I, digits=1)
		I′ = √2*E₀/Xd1 					# ′  \prime + tab
		I′ = round(I′, digits=1)
		I′′ = √2*E₀/Xd2
		I′′ = round(I′′, digits=1)

		
	elseif bancada=="B#2" || bancada=="B#3"

		I = √2*E₀/Xd
		I = round(I, digits=1)
		I′ = √2*E₀/Xd1 					# ′  \prime + tab
		I′ = round(I′, digits=1)

	end
end;

# ╔═╡ 1d75ef50-fe83-4850-ac2b-744c50a895db
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		Markdown.MD(Markdown.LaTeX("""
\\left\\{\\begin{matrix}
I = $(I) \\text{ A}\\\\
I' = $(I′) \\text{ A}\\\\
I'' = $(I′′) \\text{ A}
\\end{matrix}\\right.
"""))
	
	elseif bancada=="B#2" || bancada=="B#3"	

		Markdown.MD(Markdown.LaTeX("""
\\left\\{\\begin{matrix}
I = $(I) \\text{ A}\\\\
I' = $(I′) \\text{ A}
\\end{matrix}\\right.
"""))
	end
end

# ╔═╡ 9f3eeac5-f02d-463f-9fbc-00302801f46c
md"""
Corrente máxima da componente CC que pode ocorrer no curto-circuito em qualquer das fases, $$i_k^{dc_{max}}(t=0)$$:
"""

# ╔═╡ 14d0ea61-fe70-4063-930e-99ff46f843aa
md"""
$I_{cc}^{dc_{máx}} = i_k^{dc_{max}}(t=0) = \left\{\begin{aligned}
\sqrt{2} \frac{E_0}{X_d''} \quad \text{(com barras amortecedoras)}\\
\\
\sqrt{2} \frac{E_0}{X_d'} \quad \text{(sem barras amortecedoras)}\\
\end{aligned}\right.$

"""

# ╔═╡ fae453e2-3f9d-4fdc-9cea-d490276b9f5c
begin
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		Iᵈᶜₘₐₓ = √2 * E₀ / Xd2
		Iᵈᶜₘₐₓ =round(Iᵈᶜₘₐₓ, digits=0)

		
	elseif bancada=="B#2" || bancada=="B#3"

		Iᵈᶜₘₐₓ = √2 * E₀ / Xd1
		Iᵈᶜₘₐₓ =round(Iᵈᶜₘₐₓ, digits=0)
		
	end
end

# ╔═╡ b2b7c86b-7f28-430a-9bf6-25547be992a7
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"
		
		md"""
O que significa que a corrente máxima que pode ocorrer numa das fases no início do curto-circuito trifásico do alternador é o dobro da corrente máxima da componente subtransitória:

$I_{cc}^{máx} = I'' +I_{cc}^{dc_{máx}}$
"""

	elseif bancada=="B#2" || bancada=="B#3"

		md"""
O que significa que a corrente máxima que pode ocorrer numa das fases no início do curto-circuito trifásico do alternador é o dobro da corrente máxima da componente transitória:

$I_{cc}^{máx} = I' +I_{cc}^{dc_{máx}}$
"""
	end
end

# ╔═╡ 82c1132a-3845-4b1c-9bff-eaed8d7082d8
begin
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"
		
		Iccₘₐₓ = I′′ + Iᵈᶜₘₐₓ

				
	elseif bancada=="B#2" || bancada=="B#3"

		Iccₘₐₓ = I′ + Iᵈᶜₘₐₓ

	end
end

# ╔═╡ 6ae58e9e-55fe-4f9c-9596-a1a857808123
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"
		md"""
O valor eficaz (máximo) que pode ocorrer no curto-circuito trifásico do alternador tem em conta as duas componentes CA e CC, vem dado por:

$I_{cc}^{rms} = \sqrt{(I'')^2 + (I_{cc}^{dc_{máx}})^2}$
"""

	elseif bancada=="B#2" || bancada=="B#3"
		md"""
O valor eficaz (máximo) que pode ocorrer no curto-circuito trifásico do alternador tem em conta as duas componentes CA e CC, vem dado por:

$I_{cc}^{rms} = \sqrt{(I')^2 + (I_{cc}^{dc_{máx}})^2}$
"""
	end
end

# ╔═╡ 80a1c3e7-a9cd-4723-b354-5c0fea438f13
begin
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		Iccʳᵐˢ = √(I′′^2 + Iᵈᶜₘₐₓ^2)
		Iccʳᵐˢ = round(Iccʳᵐˢ, digits=0)

		
	elseif bancada=="B#2" || bancada=="B#3"

		Iccʳᵐˢ = √(I′^2 + Iᵈᶜₘₐₓ^2)
		Iccʳᵐˢ = round(Iccʳᵐˢ, digits=0)

	end
end

# ╔═╡ de949862-efbc-44a6-b95b-103c630e967a
aside((md"""
!!! warning "Atenção"
	**Baseie-se nas tabelas de resumo de resultados para deduzir as conclusões principais do TL5**. 
"""), v_offset=115)

# ╔═╡ cb30455b-5fb5-4125-af4a-d5a3be97fcf5
md"""
# 5 - Conclusões
"""

# ╔═╡ 378527c4-a316-423b-8ef7-6f5a5e8b81e6
md"""






"""

# ╔═╡ d37179c2-e371-460d-88cd-1a28a3b33054
md"""

**Ensaio de separação das perdas mecânicas e magnéticas**, $p_{mec+Fe}$:

 $$p_{mec}=$$ $(pᵐᵉᶜ)W


"""

# ╔═╡ 7e58216c-09c6-4e95-b019-87cca8dd8f72
md"""

| Parâmetros mecânicos $\quad$ | Obtidos |
|---:|:---|
| Momento de inércia (kg·m²), $J$:$\quad$ |  $(J) |
| Coeficiente de atrito viscoso ou dinâmico (Nm/rads⁻¹), $K_d$:$\quad$ | $(Kd) | 
| Coeficiente de atrito de Coulomb ou estático (Nm/rads⁻¹), $K_e$:$\quad$ | $(Ke) | 

"""

# ╔═╡ 5d418e52-b08e-404f-bd1a-e8d3c12ffc23
md"""






"""

# ╔═╡ 564ac000-a2b6-44f8-a8be-1d73917bbaf3
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""

| Parâmetros $\quad$ | Obtidos |
|---:|:---|
| Reatância subtransitória, $X''_d \:(\Omega)$:$\quad$ |  $(Xd2) |
| Reatância transitória, $X'_d \:(\Omega)$:$\quad$ | $(Xd1) | 
| Reatância síncrona eixo direto, $X_d \:(\Omega)$:$\quad$ | $(Xd) | 
| Constante de tempo subtransitória, $T''_d \:(\rm s)$:$\quad$ | $(Td2) | 
| Constante de tempo transitória, $T'_d \:(\rm s)$:$\quad$ | $(Td1) | 
| Constante de tempo da armadura, $T_a \:(\rm s)$:$\quad$ | $(Tₐ) |

"""

	elseif bancada=="B#2" || bancada=="B#3"

		
		md"""

| Parâmetros $\quad$ | Obtidos |
|---:|:---|
| Reatância transitória, $X'_d \:(\Omega)$:$\quad$ | $(Xd1) | 
| Reatância síncrona eixo direto, $X_d \:(\Omega)$:$\quad$ | $(Xd) | 
| Constante de tempo transitória, $T'_d \:(\rm s)$:$\quad$ | $(Td1) | 
| Constante de tempo da armadura, $T_a \:(\rm s)$:$\quad$ | $(Tₐ) |

"""

	end
end

# ╔═╡ 297f2c6e-2112-45b4-98ed-39671587950d
let
	if bancada=="B#4" || bancada=="B#5" || bancada=="B#CA"

		md"""
| Correntes de curto-circuito $\quad$ | $(\rm{A})$ |
|---:|:---:|
| Componente subtransitória máxima, $I''$:$\quad$ | $(round(I′′, digits=1)) |
| Componente transitória máxima, $I'$:$\quad$ | $(round(I′, digits=1)) |
| Regime permanente (valor máximo), $I$:$\quad$ | $(round(I, digits=1)) |
| Componente contínua máxima, $I_{cc}^{dc_{máx}}$:$\quad$ | $(round(Iᵈᶜₘₐₓ, digits=1)) |
| Corrente de curto-circuito máxima, $I_{cc}^{máx}$:$\quad$ | $(round(Iccₘₐₓ, digits=1)) |
| Valor eficaz da corrente de curto-circuito máxima, $I_{cc}^{rms}$:$\quad$ | $(round(Iccʳᵐˢ, digits=1)) |
"""

	elseif bancada=="B#2" || bancada=="B#3"
		
		md"""
| Correntes de curto-circuito $\quad$ | $(\rm{A})$ |
|---:|:---:|
| Componente transitória máxima, $I'$:$\quad$ | $(round(I′, digits=1)) |
| Regime permanente (valor máximo), $I$:$\quad$ | $(round(I, digits=1)) |
| Componente contínua máxima, $I_{cc}^{dc_{máx}}$:$\quad$ | $(round(Iᵈᶜₘₐₓ, digits=1)) |
| Corrente de curto-circuito máxima, $I_{cc}^{máx}$:$\quad$ | $(round(Iccₘₐₓ, digits=1)) |
| Valor eficaz da corrente de curto-circuito máxima, $I_{cc}^{rms}$:$\quad$ | $(round(Iccʳᵐˢ, digits=1)) |
"""
	end
end

# ╔═╡ ffe4953b-dec7-4248-8703-76504e7553f1
md"""






"""

# ╔═╡ 9642d81b-cee3-425c-9b9c-d7089b2adeb3


# ╔═╡ a8caebc7-13e9-470c-90a7-c6f0797bbd78
md"""
# Bibliografia

[^1]: [SAHDEV, S. K., "Electrical Machines", Cambridge University Press, 2018.](https://catalogo.isel.pt/cgi-bin/koha/opac-detail.pl?biblionumber=29192) Secção: "5.35 – Swinburne’s Test", p. 474.

[^2]: [IEEE Guide: Test Procedures for Direct-Current Machines, IEEE Std 113-1985, New York, 1985.](https://2526moodle.isel.pt/mod/folder/view.php?id=195248) Seçcão: “5.6 Measurement of Rotational Losses”, p. 21.

[^3]: [IEEE Guide: Test Procedures for Direct-Current Machines, IEEE Std 113-1985, New York, 1985.](https://2526moodle.isel.pt/mod/folder/view.php?id=195248) Seçcão: “7.7 Moment of Inertia Measurement”, p. 31.


"""

# ╔═╡ 0f8411f9-ba0f-4d53-aed8-d0a60a8adda0
begin
	#=
	Advanced CSS code for text formatting in Pluto.jl notebooks
	- Applies text justification and automatic hyphenation to content
	- Bilingual support: European Portuguese (pt-PT) and English (en)
	- Dynamic mapping based on the 'lang' selector variable
	- Uses system fonts with fallbacks for better compatibility
	- Significantly improves readability of long texts
	
	Developed with GenAI assistance from Claude (Anthropic) - September 2025
	=#
	
	# Language code mapping for specific locales
	#lang_code = lang == "pt" ? "pt-PT" : lang
	lang_code = "pt-PT"
	
	html"""<div lang="$(lang_code)">
	<style>
	pluto-output p {
	   text-align: justify;
	   hyphens: auto;
	   -webkit-hyphens: auto;
	   -ms-hyphens: auto;
	   -moz-hyphens: auto;
	}
	pluto-output {
	   font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
	   font-size: 100%;
	}
	</style>
	</div>
	"""
end

# ╔═╡ 7bb1e678-2b40-46f5-a94b-4021195285e1
md"""
# *Notebook*
"""

# ╔═╡ d4ed5f43-3a6d-40ca-bfc8-869938789d7e
md"""
Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [CSV](https://csv.juliadata.org/stable/), [DataFrames](https://dataframes.juliadata.org/stable/), [HTTP](https://juliaweb.github.io/HTTP.jl/stable/), [Plots](https://docs.juliaplots.org/stable/), [EasyFit](https://github.com/m3g/EasyFit.jl).
"""

# ╔═╡ 8a2c8df3-765b-43bd-96ae-916485758339
begin
	version=VERSION
	md"""
	*Notebook* desenvolvido em `Julia` versão $(version).
	"""
end

# ╔═╡ 7fc592b2-1df6-4b31-9bc5-0724d1d384d8
TableOfContents(title="Índice", depth=4)

# ╔═╡ 4056b29c-37ca-4c06-a75e-2beb8cda7beb
md"""
|  |  |
|:--:|:--|
|  | This notebook, [TL5.jl](https://ricardo-luis.github.io/me-2/TL5.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2026 [Ricardo Luís](https://ricardo-luis.github.io) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
EasyFit = "fde71243-0cda-4261-b7c7-4845bd106b21"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CSV = "~0.10.15"
DataFrames = "~1.7.1"
EasyFit = "~0.6.12"
HTTP = "~1.11.0"
Plots = "~1.41.7"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.83"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.0"
manifest_format = "2.1"
project_hash = "7c40827399c5fe7455f7fb434fe0aaac59cd69e2"

[[deps.ADTypes]]
deps = ["PrecompileTools"]
git-tree-sha1 = "629de23e1c16911b439dabd2303c08af9575b226"
registries = "General"
uuid = "47edcb42-4c32-4615-8424-f2b9edc5f35b"
version = "1.24.0"

    [deps.ADTypes.extensions]
    ADTypesChainRulesCoreExt = "ChainRulesCore"
    ADTypesConstructionBaseExt = "ConstructionBase"
    ADTypesEnzymeCoreExt = "EnzymeCore"

    [deps.ADTypes.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "e71ee7b4aa06b045259a7d6101e1cb45ad140bce"
registries = "General"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.1"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "MacroTools"]
git-tree-sha1 = "7063ad1083578215c7c4bf410368150abe8d5524"
registries = "General"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.45"

    [deps.Accessors.extensions]
    AxisKeysExt = "AxisKeys"
    IntervalSetsExt = "IntervalSets"
    LinearAlgebraExt = "LinearAlgebra"
    StaticArraysExt = "StaticArrays"
    StructArraysExt = "StructArrays"
    TestExt = "Test"
    UnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "daa72978cd7a624246e894a4f4f067706d4e17e2"
registries = "General"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.7.0"

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

    [deps.Adapt.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
registries = "General"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "daf5b2aab5b1c1fdcb65b05883cdb4b18abac1b9"
registries = "General"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.30.1"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceAMDGPUExt = "AMDGPU"
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = ["CUDSS", "CUDA"]
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceFillArraysExt = "FillArrays"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceGPUArraysCoreTrackerExt = ["GPUArraysCore", "Tracker"]
    ArrayInterfaceMetalExt = "Metal"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    AMDGPU = "21141c5a-9bdb-4563-92ae-f87d6854732e"
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FillArrays = "1a297f60-69ca-5386-bcde-b61e274b549b"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    Metal = "dde4c033-4e86-420c-a63e-0dd931031962"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitFlags]]
git-tree-sha1 = "bbe1079eecf9c9fbb52765193ad2bae27ae09bc8"
registries = "General"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.10"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
registries = "General"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "deddd8725e5e1cc49ee205a1964256043720a6c3"
registries = "General"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.15"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1fa950ebc3e37eccd51c6a8fe1f92f7d86263522"
registries = "General"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.7+0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "970758a3d591a2a5c2a907c53f2e2f8c1b1d3537"
registries = "General"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.9"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
registries = "General"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
registries = "General"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
registries = "General"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
registries = "General"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.CommonSolve]]
deps = ["PrecompileTools"]
git-tree-sha1 = "6c389fa857f6ca5a95474b52a52023fd77f24cb7"
registries = "General"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.14"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
registries = "General"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
registries = "General"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.5.5+2"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
registries = "General"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "3c9be947934c38475bafe822c6d61aaed17f0738"
registries = "General"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.6.0"

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
registries = "General"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
registries = "General"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "54b76cbb40d9a0f5368c880725b2f141da77c94f"
registries = "General"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.2.0"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
registries = "General"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "a37ac0840a1196cd00317b57e39d6586bf0fd6f6"
registries = "General"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.7.1"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "b0bc6d2cad1fed8b7fd59a1551a991cb3d2809e6"
registries = "General"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.6"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
registries = "General"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
registries = "General"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
registries = "General"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
registries = "General"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "79a2aca180a85c690c58a020d47b426954b590f8"
registries = "General"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.16.0"

[[deps.DifferentiationInterface]]
deps = ["ADTypes", "LinearAlgebra"]
git-tree-sha1 = "0693d8b0a4608ff289d228ab4c598df5894845cd"
registries = "General"
uuid = "a0c0ee7d-e4b9-4e03-894e-1c5f64a51d63"
version = "0.7.21"

    [deps.DifferentiationInterface.extensions]
    DifferentiationInterfaceChainRulesCoreExt = "ChainRulesCore"
    DifferentiationInterfaceDiffractorExt = "Diffractor"
    DifferentiationInterfaceEnzymeExt = ["EnzymeCore", "Enzyme"]
    DifferentiationInterfaceFastDifferentiationExt = "FastDifferentiation"
    DifferentiationInterfaceFiniteDiffExt = "FiniteDiff"
    DifferentiationInterfaceFiniteDifferencesExt = "FiniteDifferences"
    DifferentiationInterfaceForwardDiffExt = ["ForwardDiff", "DiffResults"]
    DifferentiationInterfaceGPUArraysCoreExt = ["GPUArraysCore", "Adapt"]
    DifferentiationInterfaceGTPSAExt = "GTPSA"
    DifferentiationInterfaceHyperHessiansExt = "HyperHessians"
    DifferentiationInterfaceMooncakeExt = "Mooncake"
    DifferentiationInterfacePolyesterForwardDiffExt = ["PolyesterForwardDiff", "ForwardDiff", "DiffResults"]
    DifferentiationInterfaceReverseDiffExt = ["ReverseDiff", "DiffResults"]
    DifferentiationInterfaceSparseArraysExt = "SparseArrays"
    DifferentiationInterfaceSparseConnectivityTracerExt = "SparseConnectivityTracer"
    DifferentiationInterfaceSparseMatrixColoringsExt = "SparseMatrixColorings"
    DifferentiationInterfaceStaticArraysExt = "StaticArrays"
    DifferentiationInterfaceSymbolicsExt = "Symbolics"
    DifferentiationInterfaceTrackerExt = "Tracker"
    DifferentiationInterfaceZygoteExt = ["Zygote", "ForwardDiff"]

    [deps.DifferentiationInterface.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DiffResults = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
    Diffractor = "9f5e2b26-1114-432f-b630-d3fe2085c51c"
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"
    FastDifferentiation = "eb9bf01b-bf85-4b60-bf87-ee5de06c00be"
    FiniteDiff = "6a86dc24-6348-571c-b903-95158fe2bd41"
    FiniteDifferences = "26cc04aa-876d-5657-8c51-4c34ba976000"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    GTPSA = "b27dd330-f138-47c5-815b-40db9dd9b6e8"
    HyperHessians = "06b494a0-c8e0-40cc-ad32-d99506a00a6c"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    PolyesterForwardDiff = "98d1487c-24ca-40b6-b7ab-df2af84e126b"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SparseConnectivityTracer = "9f842d2f-2579-4b1d-911e-f412cf18a3f5"
    SparseMatrixColorings = "0a514795-09f3-496d-8182-132a7b665d35"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    Symbolics = "0c5d862f-8b57-4792-8d23-62f2024744c7"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "Roots", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "a958ab3a40c755563f5e1405c0846cb0446bf19d"
registries = "General"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.131"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsSparseConnectivityTracerExt = "SparseConnectivityTracer"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    SparseConnectivityTracer = "9f842d2f-2579-4b1d-911e-f412cf18a3f5"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
registries = "General"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.EasyFit]]
deps = ["LsqFit", "Parameters", "Statistics", "TestItems", "Unitful"]
git-tree-sha1 = "543f0c01770c33ae511ec2b9302fb6565d92c3c4"
registries = "General"
uuid = "fde71243-0cda-4261-b7c7-4845bd106b21"
version = "0.6.12"

    [deps.EasyFit.extensions]
    SplineFitExt = "Interpolations"

    [deps.EasyFit.weakdeps]
    Interpolations = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
registries = "General"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
registries = "General"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2bfb1e047e2ad0a5ca94365340bde8005d637568"
registries = "General"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.8.4+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "95ecf07c2eea562b5adbd0696af6db62c0f52560"
registries = "General"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.5"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libva_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "7a58e45171b63ed4782f2d36fdee8713a469e6e0"
registries = "General"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "8.1.2+0"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates"]
git-tree-sha1 = "3bab2c5aa25e7840a4b065805c0cdfc01f3068d2"
registries = "General"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.24"
weakdeps = ["Mmap", "Test"]

    [deps.FilePathsBase.extensions]
    FilePathsBaseMmapExt = "Mmap"
    FilePathsBaseTestExt = "Test"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "5bad39456d9f0166184fce2248783dd9862645c1"
registries = "General"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.17.0"

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStaticArraysExt = "StaticArrays"
    FillArraysStatisticsExt = "Statistics"

    [deps.FillArrays.weakdeps]
    PDMats = "90014a1f-27ba-587c-ab20-58faa44d9150"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Setfield"]
git-tree-sha1 = "5031f23e040bf17082e5b52422d77b5e844eefb1"
registries = "General"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.33.0"

    [deps.FiniteDiff.extensions]
    FiniteDiffBandedMatricesExt = "BandedMatrices"
    FiniteDiffBlockBandedMatricesExt = "BlockBandedMatrices"
    FiniteDiffSparseArraysExt = "SparseArrays"
    FiniteDiffStaticArraysExt = "StaticArrays"

    [deps.FiniteDiff.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.FixedPointNumbers]]
deps = ["Random", "Statistics"]
git-tree-sha1 = "59af96b98217c6ef4ae0dfe065ac7c20831d1a84"
registries = "General"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.6"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
registries = "General"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
registries = "General"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "1b86cca764a61dcac4fef4c5e16e378e5ed6953c"
registries = "General"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "1.4.5"

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

    [deps.ForwardDiff.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "70329abc09b886fd2c5d94ad2d9527639c421e3e"
registries = "General"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.14.3+1"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
registries = "General"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "64bbbb7d1499297751b536dd39c58b20750ab1db"
registries = "General"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.5.1+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "4d777f73c46b46b8b5276206059cf8a195499314"
registries = "General"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.27"

    [deps.GR.extensions]
    IJuliaExt = "IJulia"

    [deps.GR.weakdeps]
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f8eb8f7ba13ea75083531647fc8faeda8d541f07"
registries = "General"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.27+0"

[[deps.Gamma]]
deps = ["LogExpFunctions"]
git-tree-sha1 = "becc397f7cfb06e343496ae6ffb04818a851da51"
registries = "General"
uuid = "a0844989-3bd2-4988-8bea-c9407ab0941b"
version = "1.2.0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
registries = "General"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
registries = "General"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "090526e65de8f69648ac156daae153de8b56df62"
registries = "General"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.88.3+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "69ffb934a5c5b7e086a0b4fee3427db2556fba6e"
registries = "General"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.16+0"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "51059d23c8bb67911a2e6fd5130229113735fc7e"
registries = "General"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.11.0"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "9d9531a9cb63a9edc33836414e82a07e81710de2"
registries = "General"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "100.14004.0+0"

[[deps.HypergeometricFunctions]]
deps = ["Gamma", "LinearAlgebra"]
git-tree-sha1 = "31bb6c92405c084617facc1d7ed9eb6c402d061e"
registries = "General"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.30"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
registries = "General"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "d1a86724f81bcd184a38fd284ce183ec067d71a0"
registries = "General"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "1.0.0"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
registries = "General"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InlineStrings]]
git-tree-sha1 = "8f3d257792a522b4601c24a577954b0a8cd7334d"
registries = "General"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.5"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.InverseFunctions]]
git-tree-sha1 = "a779299d77cd080bf77b97535acecd73e1c5e5cb"
registries = "General"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.17"
weakdeps = ["Dates", "Test"]

    [deps.InverseFunctions.extensions]
    InverseFunctionsDatesExt = "Dates"
    InverseFunctionsTestExt = "Test"

[[deps.InvertedIndices]]
git-tree-sha1 = "6da3c4316095de0f5ee2ebd875df8721e7e0bdbe"
registries = "General"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.1"

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
registries = "General"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
registries = "General"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
registries = "General"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7204148362dafe5fe6a273f855b8ccbe4df8173e"
registries = "General"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.8.0"

[[deps.JSON]]
deps = ["Dates", "Logging", "Parsers", "PrecompileTools", "StructUtils", "UUIDs", "Unicode"]
git-tree-sha1 = "c89d196f5ffb64bfbf80985b699ea913b0d2c211"
registries = "General"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "1.6.1"

    [deps.JSON.extensions]
    JSONArrowExt = ["ArrowTypes"]

    [deps.JSON.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "037babc10853eeb8e585418922246cb97b8e5b74"
registries = "General"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.2.0+1"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
registries = "General"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "39bca05343661c347aae0bca57a5994a0bf4f08d"
registries = "General"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.2.0+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e5b100780d4d30d63b4618d7930d48af409c1772"
registries = "General"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "23.1.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f88f3ccef05a6a72a0cf0ed417c8fd68530f4ab2"
registries = "General"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.1"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "df7566479bd64f20bd16b09960145e70160ffb3b"
registries = "General"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.12"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "1.0.0"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "Zstd_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.18.0+1"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "PCRE2_jll", "Zlib_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.1+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "OpenSSL_jll", "Zlib_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.103+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
registries = "General"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
registries = "General"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
registries = "General"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cc3ad4faf30015a3e8094c9b5b7f19e85bdf2386"
registries = "General"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.42.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "aebd334d06cee9f24cea70bd19a39749daf73881"
registries = "General"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.3+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d620582b1f0cbe2c72dd1d5bd195a9ce73370ab1"
registries = "General"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.42.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.13.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "bba2d9aa057d8f126415de240573e86a8f39d2a1"
registries = "General"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "1.0.1"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
registries = "General"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

[[deps.LsqFit]]
deps = ["Distributions", "ForwardDiff", "LinearAlgebra", "NLSolversBase", "Printf", "StatsAPI"]
git-tree-sha1 = "f386224fa41af0c27f45e2f9a8f323e538143b43"
registries = "General"
uuid = "2fda8390-95c7-5789-9bda-21331edee243"
version = "0.15.1"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
registries = "General"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
registries = "General"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "8785729fa736197687541f7053f6d8ab7fc44f92"
registries = "General"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.10"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ff69a2b1330bcb730b9ac1ab7dd680176f5896b8"
registries = "General"
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.1010+0"

[[deps.Measures]]
git-tree-sha1 = "b513cedd20d9c914783d8ad83d08120702bf2c77"
registries = "General"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.3"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
registries = "General"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2026.8.13"

[[deps.NLSolversBase]]
deps = ["ADTypes", "DifferentiationInterface", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "25a6638571a902ecfb1ae2a18fc1575f86b1d4df"
registries = "General"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.10.0"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "dbd2e8cd2c1c27f0b584f6661b4309609c5a685e"
registries = "General"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
registries = "General"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.30+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "NetworkOptions", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "1d1aaa7d449b58415f97d2839c318b70ffb525a0"
registries = "General"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.6.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.6+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
registries = "General"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e2bb57a313a74b8104064b7efd01406c0a50d2ff"
registries = "General"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.6.1+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05f45c2e0de6259db764adbfd2f1dc6d3f8de13c"
registries = "General"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "2.0.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.46.0+0"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "123266c25174ef6c8d4718920abc206452cf8de6"
registries = "General"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.41"
weakdeps = ["StatsBase"]

    [deps.PDMats.extensions]
    StatsBaseExt = "StatsBase"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1912a9f1b9ca55005b03ba075f8e19993583e237"
registries = "General"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.58.2+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "0ed04c372da78ff5b98e35e3bd4f4ca9931299cc"
registries = "General"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.13.1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "468dbe2b510c876dc091b2c74ed52c7c34f48b9b"
registries = "General"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.5"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "e4a6721aa89e62e5d4217c0b21bd714263779dda"
registries = "General"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.46.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "Zstd_jll", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.13.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
registries = "General"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "26ca162858917496748aad52bb5d3be4d26a228a"
registries = "General"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.4"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "83bd514e8ff16b5858ac54c53fa0bcf6002a3b00"
registries = "General"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.7"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "90b41ced6bacd8c01bd05da8aed35c5458891749"
registries = "General"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.7"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e189d0623e7ce9c37389bac17e80aac3b0302e75"
registries = "General"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.83"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
registries = "General"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "edbeefc7a4889f528644251bdb5fc9ab5348bc2c"
registries = "General"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.4"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "8b770b60760d4451834fe79dd483e318eee709c4"
registries = "General"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.2"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
registries = "General"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "4fbbafbc6251b883f4d2705356f3641f3652a7fe"
registries = "General"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.4.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "144895f6166994730ee7ff8113b981fc360638f1"
registries = "General"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.10.2+2"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll", "Qt6Svg_jll"]
git-tree-sha1 = "159d253ab126d5b29230cf53521899bea4ef4648"
registries = "General"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.10.2+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "4d85eedf69d875982c46643f6b4f66919d7e157b"
registries = "General"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.10.2+1"

[[deps.Qt6Svg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "81587ff5ff25a4e1115ce191e36285ede0334c9d"
registries = "General"
uuid = "6de9746b-f93d-5813-b365-ba18ad4a9cf3"
version = "6.10.2+0"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "672c938b4b4e3e0169a07a5f227029d4905456f2"
registries = "General"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.10.2+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "5e8e8b0ab68215d7a2b14b9921a946fee794749e"
registries = "General"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.3"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["Base64", "Dates", "FileWatching", "InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
registries = "General"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
registries = "General"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
registries = "General"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
registries = "General"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
registries = "General"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "5b3d50eb374cea306873b371d3f8d3915a018f0b"
registries = "General"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.9.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d40b2fe70437b01397d2a4d5b020008da4e7019"
registries = "General"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.2+0"

[[deps.Roots]]
deps = ["Accessors", "CommonSolve", "Printf"]
git-tree-sha1 = "4db094d5e079abbda658acfe1c4d098430417717"
registries = "General"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "3.0.8"

    [deps.Roots.extensions]
    RootsChainRulesCoreExt = "ChainRulesCore"
    RootsForwardDiffExt = "ForwardDiff"
    RootsIntervalRootFindingExt = "IntervalRootFinding"
    RootsSymPyExt = "SymPy"
    RootsSymPyPythonCallExt = "SymPyPythonCall"
    RootsUnitfulExt = "Unitful"

    [deps.Roots.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    IntervalRootFinding = "d2bf35a9-74e0-55ec-b149-d360ff49b807"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
    SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "1.0.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
registries = "General"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "712fb0231ee6f9120e005ccd56297abbc053e7e0"
registries = "General"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.8"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
registries = "General"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

[[deps.Showoff]]
deps = ["Dates"]
git-tree-sha1 = "8238217340ad0aaabe11afe39c1098b5bc9f4c8e"
registries = "General"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.1.1"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
registries = "General"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "13cd91cc9be159e3f4d95b857fa2aa383b53772a"
registries = "General"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.3"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.13.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "429071b23f4c9a13fb6582f807cc2ef454082408"
registries = "General"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.9.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "4f96c596b8c8258cc7d3b19797854d368f243ddc"
registries = "General"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.4"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6ab403037779dae8c514bad259f32a447262455a"
registries = "General"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.4"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "e2b53ce13a53367e96601081e33d34746b571bad"
registries = "General"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.5"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "178ed29fd5b2a2cfc3bd31c13375ae925623ff36"
registries = "General"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.8.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "IrrationalConstants", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "adb9da019510162e67a4493fc235c23203d8b09e"
registries = "General"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.13"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "91a5737baed20ee31f3faea0e51f57461f6a689e"
registries = "General"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "2.2.1"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "d05693d339e37d6ab134c5ab53c29fce5ee5d7d5"
registries = "General"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.4"

[[deps.StructUtils]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "2d0fc55c61321ba245c47be599570d11bac50303"
registries = "General"
uuid = "ec057cc2-7a8d-4b58-b3b3-92acb9f63b42"
version = "2.8.5"

    [deps.StructUtils.extensions]
    StructUtilsMeasurementsExt = ["Measurements"]
    StructUtilsStaticArraysCoreExt = ["StaticArraysCore"]
    StructUtilsTablesExt = ["Tables"]

    [deps.StructUtils.weakdeps]
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.10.1+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
registries = "General"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "a94d9bdda1b7bed0046cea645639ab3f62196fac"
registries = "General"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.14.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
registries = "General"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TestItems]]
git-tree-sha1 = "42fd9023fef18b9b78c8343a4e2f3813ffbcefcb"
registries = "General"
uuid = "1c621080-faea-4a02-84b6-bbd5e436b8fe"
version = "1.0.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
registries = "General"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
registries = "General"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "908fec9df6c5de98548ead82a468c95ccf6cd263"
registries = "General"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.7.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
registries = "General"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
registries = "General"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "c25751629f5baaa27fef307f96536db62e1d754e"
registries = "General"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.27.0"
weakdeps = ["ConstructionBase", "ForwardDiff", "InverseFunctions", "LaTeXStrings", "Latexify", "NaNMath", "Printf"]

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    LatexifyExt = ["Latexify", "LaTeXStrings"]
    NaNMathExt = "NaNMath"
    PrintfExt = "Printf"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
registries = "General"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
registries = "General"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
registries = "General"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
registries = "General"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
registries = "General"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e52eca002a11c30a858185efdfb15311e1c7a6bf"
registries = "General"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.4+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
registries = "General"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
registries = "General"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "808090ede1d41644447dd5cbafced4731c56bd2f"
registries = "General"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.13+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
registries = "General"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
registries = "General"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
registries = "General"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "1a4a26870bf1e5d26cd585e38038d399d7e65706"
registries = "General"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.8+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
registries = "General"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "dcb316b3ce0941f195537dda56bea4517fcd3ff5"
registries = "General"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.4+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "0ba01bc7396896a4ace8aab67db31403c71628f4"
registries = "General"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.7+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c174ef70c96c76f4c3f4d3cfbe09d018bcd1b53"
registries = "General"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.6+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
registries = "General"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libpciaccess_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "58972370b81423fc546c56a60ed1a009450177c3"
registries = "General"
uuid = "a65dc6b1-eb27-53a1-bb3e-dea574b5389e"
version = "0.19.0+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
registries = "General"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "ed756a03e95fff88d8f738ebc2849431bdd4fd1a"
registries = "General"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.2.0+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
registries = "General"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
registries = "General"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
registries = "General"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
registries = "General"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
registries = "General"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
registries = "General"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
registries = "General"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "2e59214e017a55cb87474a00fa76035c82ac0e17"
registries = "General"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.47.0+2"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
registries = "General"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["CompilerSupportLibraries_jll", "Libdl"]
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
registries = "General"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
registries = "General"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ef17c47d22224aaecc76e597ab21a072e025cf7b"
registries = "General"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.14.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "cb007192783c56d8249db4cf0e3495001edfe414"
registries = "General"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
registries = "General"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libdrm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libpciaccess_jll"]
git-tree-sha1 = "28e57478e8a160d346a19c28b3fffb9273bcc9c2"
registries = "General"
uuid = "8e53e030-5e6c-5a89-a30b-be5b7263a166"
version = "2.4.134+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
registries = "General"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
registries = "General"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
registries = "General"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e51150d5ab85cee6fc36726850f0e627ad2e4aba"
registries = "General"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.58+0"

[[deps.libva_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "libdrm_jll"]
git-tree-sha1 = "7dbf96baae3310fe2fa0df0ccbb3c6288d5816c9"
registries = "General"
uuid = "9a156e7d-b971-5f62-b2c9-67348b8fb97c"
version = "2.23.0+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
registries = "General"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
registries = "General"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.67.1+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.8.2+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
registries = "General"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
registries = "General"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "a1fc6507a40bf504527d0d4067d718f8e179b2b8"
registries = "General"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.13.0+0"

[registries.General]
url = "https://github.com/JuliaRegistries/General.git"
uuid = "23338594-aafe-5451-b93e-139f81909106"
"""

# ╔═╡ Cell order:
# ╟─2c8630b8-91e2-4563-814d-7d310cffb4ef
# ╟─ed32cd37-3b8b-439a-9c96-ca7da5e7a061
# ╟─73edb666-0186-4298-a61d-c708c77e9010
# ╟─d41f2f9e-a0e7-4a1f-a958-cd8f5ba7ffe5
# ╟─cd6d3267-4cf1-436f-aeaf-f37f48ca1eab
# ╟─58642ad2-3aeb-4c55-ac3a-0cd1cd7bfaaf
# ╟─e51a2abf-e00d-4b80-aee4-9a740a8d8244
# ╟─ae2dd8d9-7774-42d9-8daa-de671c778558
# ╟─684c6152-63c6-47c4-a20d-d34bf2cc033b
# ╟─2324d582-e948-40d9-a5ca-e7af0c5d9321
# ╟─5fdb7601-2f73-4f08-8517-668df1886c33
# ╟─6161d57a-030f-4c47-8b35-41b1425146d4
# ╟─6359c098-d334-42ac-960f-190c73695606
# ╟─a468e6c6-8987-41dd-adfc-27f9c37e297c
# ╟─4d4e1abb-7063-4da4-b3a8-038499a94f97
# ╟─0ac3d670-a191-49e5-9242-e06e2230d8dc
# ╟─b7c67c72-bf87-4e5d-8169-1fe73e977f9d
# ╟─d015d7ea-8412-4bf3-8d4e-d8b895a5ee8f
# ╟─fcd5fea9-c3a3-4480-8242-75b3cce8d099
# ╟─3dc2f1ac-cdd0-460c-803f-47b6e91fc618
# ╟─ced15987-9ff1-4214-b30d-78e3805d9212
# ╟─8359da3d-375d-4a74-a49d-adc8e4611bab
# ╟─3be5a557-c355-466f-b439-e31d86823593
# ╟─d496fd8e-111c-4f94-bef4-37d08010e8b0
# ╟─2a460ffd-8507-4b9e-b367-6c6448329a9e
# ╟─7c2f9a07-bc0f-49a9-8fab-89299d0098f1
# ╟─663dee2f-75f6-4923-8c21-fc9daac8d095
# ╟─a8740a11-78f2-418f-94fe-b98fde0ef992
# ╟─d77d021c-7d48-43ce-8ea4-4e2571bd1491
# ╠═cdbe0d0c-ce72-405f-a80a-a52df24c6c03
# ╠═66a50cc3-7bea-45d0-908f-b12c529e82f2
# ╠═5098a9ca-89f7-4f6d-8bfc-9eb18110e176
# ╟─4aaf3368-5614-4aef-ae4a-400efcf74895
# ╠═881564ee-5219-451f-8346-658f0aa4972f
# ╟─e9dd8aa4-5377-4877-9569-0720cda2504a
# ╠═c7773506-b308-431d-adb2-0c55c72e8879
# ╟─fb684796-9a16-41f2-bfe4-a4cb9160c265
# ╟─8e400126-63be-41db-b264-f3bbc7cda806
# ╟─07fe612f-3742-4d1b-bc90-c1fdf8bab30f
# ╟─b6805114-cac1-4866-ba9e-312946b7feb4
# ╠═a0e94996-dc43-4967-bda2-7cc9498a1eeb
# ╠═bb9916c2-47ee-403b-8382-ef41fbca57c3
# ╟─058f892b-1705-4821-bd6c-813fc6f30a78
# ╠═4193cb25-de59-49bb-a329-4c173ca18f8e
# ╠═1ba364ee-8920-4a9f-ad36-29d882f560eb
# ╟─488a36a0-fef6-475d-9f69-56801f0059f7
# ╟─fe4db7cb-f5fb-48d5-a26c-241a153ac55d
# ╟─e8dece0d-9a75-4e67-80ff-118603691c1e
# ╟─6c48f0d5-70cb-4cfa-80a2-2a3f2f5e84b1
# ╟─22598e72-fd83-4556-8a83-d1f32b919585
# ╟─3ea09b6d-e0a3-44fd-a0fa-99d4c6933321
# ╠═af146314-12f3-4e2c-a8cd-86e9f487e012
# ╟─39bd6233-e7ea-4b7d-bcb3-9538e6229de0
# ╟─c447185a-f13d-4d11-8233-1f572db1f917
# ╟─a8708162-de5d-4681-a23c-1c1019e9e3a5
# ╟─f917bfd2-d302-4845-88b3-fbf2127c054a
# ╠═ca9b9f44-bd2b-4baa-911c-ed2f09c009a0
# ╟─9c9af988-29f2-4bc6-b03f-56e694c27de3
# ╟─ba7bd9cf-44b4-40b5-a1d3-159f599e998f
# ╟─d41137aa-61f1-4efe-b3dd-6cba76026ecc
# ╠═43749024-ed93-41b0-9f62-e458e2abcfd5
# ╟─0d3b2041-9633-44bf-a09f-0d0626205826
# ╟─169ab7ab-14b1-4997-889c-6e7e1ff80147
# ╟─85f60edb-7ed6-4684-a332-488874658a59
# ╟─43a89c9e-85a1-49f9-852f-b02fed01dd0c
# ╟─3d129e5b-cb06-47b0-9490-f8391a9d120c
# ╠═df3ba2f9-aaf4-4579-89ad-69113ce5dc8e
# ╠═a9c02270-4c71-490a-928f-d465e8764576
# ╟─3ce227cc-37a2-4cd0-be06-d90e1cb23e0b
# ╟─8a565e25-34f2-459d-819f-c88cbc6d9c15
# ╟─1660096b-1f6f-426c-8a4b-5ab59e17bc10
# ╟─d365359b-6759-44c3-bf09-c35dadd62b29
# ╠═14584720-6811-4774-9fc0-54ce524c89c4
# ╟─258ecb33-9396-4d9c-afe4-871fd165b014
# ╟─866265b0-4c95-41ee-ad33-828868cf7fa9
# ╟─3355f4d0-fc6f-4b2c-88a3-79e2a3f93b60
# ╠═7d7befd2-5c57-401e-aa11-c922b301a6cf
# ╟─2c36c4b8-6fd9-4c7e-b448-b723c9845fbd
# ╟─e007c3d9-19d6-4184-8389-8da9e9c43f6f
# ╟─72d27ac6-ada4-42ed-8639-a5cfdba36283
# ╠═3f20fbab-1649-4e64-ad67-82e68e9995ca
# ╟─7f3d23eb-66c6-4bdd-a777-87f165464b49
# ╠═fb5393a1-fca2-4512-bf78-1a36d61f99f5
# ╠═3ade6db8-8f2b-4de2-b981-038fe785d091
# ╟─425b6829-9b2f-4fdd-be67-aeed6daade64
# ╟─b37b67e2-b6c8-40d4-8a2c-0e67b4f9baa4
# ╟─168fcba2-8cdb-4265-97b2-8e5911b06867
# ╟─cf19d614-6eef-423d-8844-6c845dcfa352
# ╟─2f25d04e-f1d4-413d-88fc-ccc005aabf06
# ╟─e4b18448-f22c-469a-9ebf-2b9ebeaae1e5
# ╠═270fa2d8-052c-4723-8abe-8c4a405c09fd
# ╟─d1b64d93-0b69-4e5f-b67c-5553149f5e9c
# ╟─fc8898a7-0a7a-4885-baec-3b8be4b7287a
# ╟─5a1b9117-e6d3-4173-8089-0c506beaba89
# ╠═0d975012-eeeb-4e0c-ae69-caf8b75ffca0
# ╟─c170e12d-1c24-4de5-84ae-d17f34429b73
# ╠═7b8a8aaa-de42-49ca-ac85-932e15f7267a
# ╠═c9cbbbbe-4094-4f40-9870-8743051b7918
# ╟─9630dc3a-f47c-4837-b5bf-83f877f0f86a
# ╟─14f8ffdb-f860-47d0-bbba-aa212338feea
# ╠═77c311bb-a653-4f3d-a2d3-a214346bf2fe
# ╟─3fbd3f6e-6a41-4218-9eef-2f83a15f2a58
# ╟─e8d9674b-2805-49f9-ad69-8c53e43a6788
# ╟─7973d2bd-9da2-4207-a312-05c96821ffaf
# ╠═53e373f3-1cfd-49c5-ad0c-409c1e9bb6f1
# ╠═580feaab-480a-40ee-871c-fa6fd8d66e7b
# ╠═18c70d80-e5a1-4723-a5c4-abedb813a1bd
# ╠═d297b3cc-bcf8-4ee3-8932-6a5a071a3830
# ╟─029b40b9-dbec-4123-88c1-2eb34e842a79
# ╟─d9c5c3b6-1879-4dd5-b4c0-6ba182883577
# ╟─fda4d4b4-c824-4f27-81e8-80f323643be9
# ╟─7276a59b-8d1e-4cd5-9aaa-827688769bdd
# ╟─6af3525f-4738-453d-99ab-e492fc015315
# ╟─cc784ba6-ab5a-4e5d-941b-6eab7a802573
# ╟─eb99b716-1cee-456f-ba52-90e259325870
# ╟─744f81be-d3d2-4de4-904d-b68f3c66348f
# ╟─d0aa166a-3483-4a00-baa0-d1851ad5b9e0
# ╟─e8d4090a-d1a4-44e8-ba05-a71bac47b128
# ╟─09ed7123-dceb-451c-8007-f3fef2ae71b9
# ╟─b76a8e9f-6c36-428b-9026-4c3418c22661
# ╟─d744b733-4a46-4205-ba52-729a77287f5a
# ╠═23d66072-6000-4e23-85e1-546310bdff73
# ╠═89bbcfcb-cd64-430c-a27c-d9196bd6a89f
# ╠═14eeae09-0570-4fb5-a320-cbf8dca52f4b
# ╟─771d170b-a71c-44ae-980b-101f9dca5bc4
# ╟─1b43458f-e1a0-4f6b-aee5-bb845e678831
# ╟─2ddd9860-3743-4289-abbc-4441f2e65d76
# ╟─42a5e605-cfe0-4fea-88a3-947b415b916b
# ╠═a275790e-6310-4151-a6db-f67c79b94766
# ╟─aed0bfbc-f8e9-466c-a0cb-2ed38f0e6af5
# ╟─73f98aff-0780-446a-a1bf-9c275a6dd0e6
# ╟─e55c00d3-cf2c-49ff-a9af-1d22d5b16c09
# ╠═c36c0a70-4159-4b96-8d81-463fd0a214cc
# ╟─ed0de60c-de58-4f40-89dd-77e100854325
# ╟─a7340aeb-76bc-4819-9cbb-24547d29a3bf
# ╟─5d0d7d02-4695-4cb6-93f6-8aa57e2e2b88
# ╟─294e716b-31a0-4c27-8d9f-b1fe16c8debd
# ╟─bc17b1d4-3fef-4e50-9527-74497fd925a7
# ╟─a477ab78-ce11-4ce5-85b5-df7b18c48e92
# ╟─277aa9c5-b50d-45e8-9a1f-309d0190b9cc
# ╟─1d75ef50-fe83-4850-ac2b-744c50a895db
# ╠═cacc04e1-05ea-4537-bdba-76375f000277
# ╟─9f3eeac5-f02d-463f-9fbc-00302801f46c
# ╟─14d0ea61-fe70-4063-930e-99ff46f843aa
# ╠═fae453e2-3f9d-4fdc-9cea-d490276b9f5c
# ╟─b2b7c86b-7f28-430a-9bf6-25547be992a7
# ╠═82c1132a-3845-4b1c-9bff-eaed8d7082d8
# ╟─6ae58e9e-55fe-4f9c-9596-a1a857808123
# ╠═80a1c3e7-a9cd-4723-b354-5c0fea438f13
# ╟─de949862-efbc-44a6-b95b-103c630e967a
# ╟─cb30455b-5fb5-4125-af4a-d5a3be97fcf5
# ╠═378527c4-a316-423b-8ef7-6f5a5e8b81e6
# ╟─d37179c2-e371-460d-88cd-1a28a3b33054
# ╟─7e58216c-09c6-4e95-b019-87cca8dd8f72
# ╠═5d418e52-b08e-404f-bd1a-e8d3c12ffc23
# ╟─564ac000-a2b6-44f8-a8be-1d73917bbaf3
# ╟─297f2c6e-2112-45b4-98ed-39671587950d
# ╠═ffe4953b-dec7-4248-8703-76504e7553f1
# ╟─9642d81b-cee3-425c-9b9c-d7089b2adeb3
# ╟─a8caebc7-13e9-470c-90a7-c6f0797bbd78
# ╟─0f8411f9-ba0f-4d53-aed8-d0a60a8adda0
# ╟─7bb1e678-2b40-46f5-a94b-4021195285e1
# ╟─d4ed5f43-3a6d-40ca-bfc8-869938789d7e
# ╠═03d72091-391f-4858-b7f8-969e47288be9
# ╟─8a2c8df3-765b-43bd-96ae-916485758339
# ╠═7fc592b2-1df6-4b31-9bc5-0724d1d384d8
# ╟─4056b29c-37ca-4c06-a75e-2beb8cda7beb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
