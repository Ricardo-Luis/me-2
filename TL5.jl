### A Pluto.jl notebook ###
# v0.20.15

#> [frontmatter]
#> image = "https://github.com/Ricardo-Luis/me-2/blob/97a15bd381dd18a6f9932993655f62d4a9c99f23/images/card/TL5.png?raw=true"
#> title = "TL5 - Transitórios de Máquinas Elétricas"
#> date = "2025-09-01"
#> layout = "layout.jlhtml"
#> description = "Guia/relatório sobre o Trabalho Laboratorial n.º 5 (TL5). Este trabalho visa estudar os regimes transitórios de máquinas de corrente contínua (MCC) e síncronas trifásicas (MST) através de ensaios específicos. Para a MCC realizam-se ensaio em vazio para determinar perdas mecânicas e magnéticas, e ensaio de desaceleração para obter parâmetros mecânicos como momento de inércia e coeficientes de atrito, permitindo estabelecer a equação mecânica fundamental para simulação. Para a MST analisa-se o comportamento transitório durante um curto-circuito trifásico aplicado ao alternador em vazio, estudo essencial para o dimensionamento adequado de equipamentos de proteção como disjuntores e relés, garantindo a segurança e integridade do sistema elétrico."
#> tags = ["Dynamics of Electrical Machines"]
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

# ╔═╡ bbb73813-b32d-4440-baf0-0a8ef335accb
using PlutoUI, PlutoTeachingTools, CSV , DataFrames, HTTP, Plots
#=
Short packages description:
 - PlutoUI.jl, to add interactivity objects to notebook
 - PlutoTeachingTools.jl, to enhance the notebook
 - CSV.jl, a CSV (Comma Separated Values) file reading and writing
 - DataFrames.jl, Data manipulation and analysis with tabular structures
 - HTTP.jl, HTTP client and server functionality for web request
 - Plots.jl, visualization interface and toolset to build graphics
=#

# ╔═╡ 2c8630b8-91e2-4563-814d-7d310cffb4ef
TwoColumnWideLeft(md"`TL5.jl`", md"`Last update: 01·09·2025`")

# ╔═╡ ed32cd37-3b8b-439a-9c96-ca7da5e7a061
md"""
---
$\textbf{RELATÓRIO TL5}$ 

$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Transitórios de Máquinas Elétricas}}}$
---
"""

# ╔═╡ f86aa1d6-ff9a-49b5-93af-2dd91a0a8781
TODO("Este notebook está em desenvolvimento..."; heading="Work in progress")

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

# ╔═╡ cb9cd8b4-421c-4081-bceb-74525f3eeadd


# ╔═╡ cd6d3267-4cf1-436f-aeaf-f37f48ca1eab


# ╔═╡ 58642ad2-3aeb-4c55-ac3a-0cd1cd7bfaaf
md"""
# 2 - Procedimentos de ensaios
"""

# ╔═╡ e51a2abf-e00d-4b80-aee4-9a740a8d8244


# ╔═╡ ae2dd8d9-7774-42d9-8daa-de671c778558
md"""
## 2.1 - Esquemas de ligações
"""

# ╔═╡ d88fe3ad-5896-412a-81dd-8bc94a03b64c


# ╔═╡ a16531f0-3acc-4a5e-a3cd-7285bf131687
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:	
   raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/TL5/MotorDC_decel.drawio"
   
# Adjustable settings:
   iframe_width = 690
   iframe_height = 350
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
Fig. 1 - Esquema de ligações para os ensaios de vazio e de desaceleração do motor CC.
"""

# ╔═╡ 05dc1b9c-d8ee-4025-8461-e6d799e158f0


# ╔═╡ 98c0b6ff-f4aa-43c4-819e-d27dcb08d3be
md""" Acionamento utilizado? $(@bind motor Select([
		"DC" => "Motor CC",
		"AC" => "Motor CA",]))
"""

# ╔═╡ 59d46295-7090-4ccf-b916-b79e99dfd730
let
	if motor=="DC"
		# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:	
		raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/TL5/SCalt_driver_DCmotor.drawio"

		# Adjustable settings:
		iframe_width = 690
		iframe_height = 350
		
		# 1 = fit diagram to iframe size (keeps aspect ratio); 0 = original diagram size
		fit = 0 

		# viewer_url build 
		viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&fit=$(fit)#U" * raw_url

		# HTML
		HTML("""
			 <div style="text-align: center;">
			 	<iframe frameborder="0" 
			 	style="width:$(iframe_width)px; height:$(iframe_height)px; border: 		1px solid #ddd;"
			 	src="$(viewer_url)">
			 	</iframe>
   			</div>
   			""")
	elseif motor=="AC"
				# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:	
		raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/TL5/SCalt_driver_ACmotor.drawio"

		# Adjustable settings:
		iframe_width = 690
		iframe_height = 350
		
		# 1 = fit diagram to iframe size (keeps aspect ratio); 0 = original diagram size
		fit = 0 

		# viewer_url build 
		viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&fit=$(fit)#U" * raw_url

		# HTML
		HTML("""
			 <div style="text-align: center;">
			 	<iframe frameborder="0" 
			 	style="width:$(iframe_width)px; height:$(iframe_height)px; border: 		1px solid #ddd;"
			 	src="$(viewer_url)">
			 	</iframe>
   			</div>
   			""")
	end
end

# ╔═╡ 4e175b3c-b247-4502-b8a0-8e30d652f611
md"""
Fig. 2 - Esquema de ligações para o ensaio do transitório de um curto-circuito trifásico num alternador síncrono em vazio.
"""

# ╔═╡ b2d7ea8b-4e7b-4a66-b070-fd06db7c4ee8


# ╔═╡ 6161d57a-030f-4c47-8b35-41b1425146d4
md"""
## 2.2 - Material utilizado
"""

# ╔═╡ a468e6c6-8987-41dd-adfc-27f9c37e297c
md"""
**Máquinas elétricas**

Foram utilizadas as máquinas elétricas: motor CC e alternador síncrono 3~ do grupo conversor CC-CA do Lab. de Máquinas Elétricas.


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
| **kW**  |   8  |  **cos φ** |  0,8  | **Δ: V** | 220 | **A** | 26,2 | 
| **kVA** |  10  |  **cos φ** |  0,8  | **Y: V** | 380 | **A** | 15,2 |
| **rpm** | 1500 |   **Ph**   |  3    |  **Hz**  |  50 |       |      |
|         |      | **Excit.** |  SEP  |   **V**  | 100 | **A** | 0,50 |

\

- Dínamo taquimétrico: RADIO-ENERGIE (fabricante)
  - Modelo: REo 444
  - Constante de velocidade: 0,06 V/rpm
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

# ╔═╡ 4d4e1abb-7063-4da4-b3a8-038499a94f97


# ╔═╡ 0ac3d670-a191-49e5-9242-e06e2230d8dc
md"""
## 2.3 - Condução do trabalho
"""

# ╔═╡ b7c67c72-bf87-4e5d-8169-1fe73e977f9d


# ╔═╡ 3dc2f1ac-cdd0-460c-803f-47b6e91fc618


# ╔═╡ 663dee2f-75f6-4923-8c21-fc9daac8d095
md"""
# 3 - Resultados experimentais
"""

# ╔═╡ a8740a11-78f2-418f-94fe-b98fde0ef992
md"""
## 3.1 - Ensaios no motor CC
"""

# ╔═╡ d77d021c-7d48-43ce-8ea4-4e2571bd1491
md"""
### 3.1.1 - Ensaio de separação das perdas mecânicas e do ferro
"""

# ╔═╡ 62c2eb5f-8e77-4f9d-89df-e76bf3466d05


# ╔═╡ cdbe0d0c-ce72-405f-a80a-a52df24c6c03
U=[220, 210, 200, 190, 180, 170, 160, 151, 140, 130, 121, 110, 100, 92] #voltage, V

# ╔═╡ 66a50cc3-7bea-45d0-908f-b12c529e82f2
I=[2720, 2730, 2740, 2780, 2816, 2870, 3036, 3080, 3180, 3353, 3492, 3730, 4010, 4335] #current, mA 

# ╔═╡ 5098a9ca-89f7-4f6d-8bfc-9eb18110e176
data1 = (select=[U,I], DataFrame)

# ╔═╡ 4aaf3368-5614-4aef-ae4a-400efcf74895
md"""
Resistência do induzido (Ω):
"""

# ╔═╡ 881564ee-5219-451f-8346-658f0aa4972f
Rᵢ = 0.834

# ╔═╡ e04c6791-658c-495f-92d9-0988bfad036e
md"""
Cálculo das perdas mecânicas e do ferro, $p_{\rm{mec+Fe}} \:, \rm{(W)}$:
"""

# ╔═╡ c7773506-b308-431d-adb2-0c55c72e8879
pₗₒₛₛₑₛ = U .* (I/1000) .- Rᵢ * (I/1000).^2

# ╔═╡ fb684796-9a16-41f2-bfe4-a4cb9160c265
scatter(U, pₗₒₛₛₑₛ, xaxis=[0,240], yaxis=[0, 600], xlabel="Tensão (V)", 
					ylabel="Perdas mecânicas e do ferro (W)", label=:none)

# ╔═╡ 8e400126-63be-41db-b264-f3bbc7cda806


# ╔═╡ 07fe612f-3742-4d1b-bc90-c1fdf8bab30f
md"""
### 3.1.2 - Ensaio de desaceleração
"""

# ╔═╡ b6805114-cac1-4866-ba9e-312946b7feb4
md"""
Acesso ao ficheiro de dados (CSV):
"""

# ╔═╡ a0e94996-dc43-4967-bda2-7cc9498a1eeb
# Load CSV data from OneDrive SharePoint
# Required packages: CSV.jl, DataFrames.jl, HTTP.jl

# OneDrive SharePoint direct download URL
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

# ╔═╡ c447185a-f13d-4d11-8233-1f572db1f917
md"""
#### 3.1.2.2 - Representação gráfica do ensaio de desaceleração
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
Tacho_gain = 0.06 # V/rpm

# ╔═╡ 43749024-ed93-41b0-9f62-e458e2abcfd5
velocidade = (ch1_cc / Volt_probe ) / Tacho_gain

# ╔═╡ 0d3b2041-9633-44bf-a09f-0d0626205826
md"""
Ajustar o instante t=0 para o início do ensaio: $$\Delta t (s)=$$ $(@bind Δt_cc Slider(0:0.01:6; default=3.17, show_value=true)) 
"""

# ╔═╡ 169ab7ab-14b1-4997-889c-6e7e1ff80147
plot(t_cc.-Δt_cc, velocidade, ylabel="Velocidade (rpm)", xlabel="Tempo (s)", 		 							  label=:none)

# ╔═╡ bd79a7d7-edbf-45c7-8b01-6c60838f623d


# ╔═╡ 22e5c592-cd81-430f-8fab-34f3cec588ca


# ╔═╡ 43a89c9e-85a1-49f9-852f-b02fed01dd0c
md"""
## 3.2 - Transitório de curto-circuito no alternador
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
### 3.2.1 - Decimação de dados do osciloscópio
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


# ╔═╡ e007c3d9-19d6-4184-8389-8da9e9c43f6f
md"""
### 3.2.2 - Representação temporal das correntes
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
# 4 - Análise de resultados
"""

# ╔═╡ e4b18448-f22c-469a-9ebf-2b9ebeaae1e5


# ╔═╡ 3fbd3f6e-6a41-4218-9eef-2f83a15f2a58


# ╔═╡ e8d9674b-2805-49f9-ad69-8c53e43a6788
md"""
## 4.1 - Motor CC
"""

# ╔═╡ 8bccbf30-89a0-4561-86d4-06d788a7d29f


# ╔═╡ 029b40b9-dbec-4123-88c1-2eb34e842a79


# ╔═╡ 580feaab-480a-40ee-871c-fa6fd8d66e7b
ω₀ = 1440;

# ╔═╡ 53e373f3-1cfd-49c5-ad0c-409c1e9bb6f1
tw=0.0:1e-3:22.0; # time range

# ╔═╡ d9c5c3b6-1879-4dd5-b4c0-6ba182883577
md"""
Kd $(@bind Kd Slider(0:1e-4:0.5; default=0.015, show_value=true))\
Ke $(@bind Ke Slider(0:1e-3:10; default=0.0, show_value=true))\
J $(@bind J Slider(0:1e-2:0.4; default=0.3, show_value=true))\
"""

# ╔═╡ 37b550c6-60d3-49ef-90fb-cde7a868d744
a=Kd/J;

# ╔═╡ 6a843590-dd2b-405e-b0dd-249254c9dd93
ω = ω₀ * exp.(-a*tw) .- (Ke/Kd)*(1 .- exp.(-a*tw)) 

# ╔═╡ fda4d4b4-c824-4f27-81e8-80f323643be9
begin
	plot(t_cc.-Δt_cc, velocidade, ylabel="Velocidade (rpm)", xlabel="Tempo (s)", 								  label="osciloscópio") 
	plot!(tw, ω, label="teórico")	
end

# ╔═╡ 67004f21-139f-4535-b637-2b28b9762a1a


# ╔═╡ 015c0c72-e797-40b9-8cc4-102a0bec4445


# ╔═╡ 7276a59b-8d1e-4cd5-9aaa-827688769bdd


# ╔═╡ 6af3525f-4738-453d-99ab-e492fc015315
md"""
## 4.2 - Alternador
"""

# ╔═╡ 23d66072-6000-4e23-85e1-546310bdff73
tt = 0.0:0.001:0.45;

# ╔═╡ 89bbcfcb-cd64-430c-a27c-d9196bd6a89f
E₀=400/√3; f=46.5

# ╔═╡ 275ef195-f335-48eb-9c4e-2c5d27379d01
md"""
Xdʼʼ $(@bind Xd2 Slider(1:0.01:100.0; default=4.0, show_value=true))\
Xdʼ $(@bind Xd1 Slider(1:0.01:200.0; default=4.1, show_value=true))\
Xd $(@bind Xd Slider(1:1:350.0; default=60, show_value=true))\
Tdʼʼ $(@bind Td2 Slider(1e-4:1e-4:1e-1; default=4.4e-3, show_value=true))\
Tdʼ $(@bind Td1 Slider(1e-4:1e-4:1e-1; default=14e-3, show_value=true))\
$$\alpha =$$ $(@bind α NumberField(-360:0.1:360.0, default=-92))$$\degree$$\
$$\theta =$$ $(@bind θ Slider(-360:1:360.0, default=0, show_value=true))$$\degree$$\
Ta $(@bind Tₐ Slider(1e-4:0.1e-3:10e-1; default=0.4e-3, show_value=true))\

"""

# ╔═╡ 14eeae09-0570-4fb5-a320-cbf8dca52f4b
iᵃᶜ = √2*E₀*((1/Xd2-1/Xd1)*exp.(-tt/Td2) .+ (1/Xd1-1/Xd)*exp.(-tt/Td1) .+ 1/Xd).*sin.(2π*f*tt .+ deg2rad(α) .- π/2 .+ deg2rad(θ))

# ╔═╡ a275790e-6310-4151-a6db-f67c79b94766
iᵈᶜ = √2*(E₀/Xd2)*sin(deg2rad(α) - π/2) .* exp.(-tt/Tₐ)

# ╔═╡ c36c0a70-4159-4b96-8d81-463fd0a214cc
i = iᵃᶜ + iᵈᶜ

# ╔═╡ 294e716b-31a0-4c27-8d9f-b1fe16c8debd
begin
	plot(t_SC.+0.011, i₁, xaxis=[-0.05,0.46], yaxis=[-120, 120], 
		 				   ylabel="Corrente estator (A)", xlabel="Tempo (s)", label="Osciloscópio")
	plot!(tt, i, label="Modelo teórico")
end

# ╔═╡ bc17b1d4-3fef-4e50-9527-74497fd925a7


# ╔═╡ 5fa9acdd-0307-45ca-a91a-b8216e4bf73d


# ╔═╡ de949862-efbc-44a6-b95b-103c630e967a


# ╔═╡ cb30455b-5fb5-4125-af4a-d5a3be97fcf5
md"""
# 5 - Conclusões
"""

# ╔═╡ 378527c4-a316-423b-8ef7-6f5a5e8b81e6


# ╔═╡ 564ac000-a2b6-44f8-a8be-1d73917bbaf3


# ╔═╡ 5c9ede2a-a671-4a56-ba53-8a38c5f7ec8c


# ╔═╡ a8caebc7-13e9-470c-90a7-c6f0797bbd78


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
Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [CSV](https://csv.juliadata.org/stable/), [DataFrames](https://dataframes.juliadata.org/stable/), [HTTP](https://juliaweb.github.io/HTTP.jl/stable/), [Plots](https://docs.juliaplots.org/stable/).
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

# ╔═╡ 020ebbaf-5914-47d8-82f7-7f948e2903ad
aside((md"""
!!! info
	No índice deste *notebook*, o tópico assinalado com "💻" requer a participação do estudante.
"""), v_offset=-100)

# ╔═╡ 4056b29c-37ca-4c06-a75e-2beb8cda7beb
md"""
|  |  |
|:--:|:--|
|  | This notebook, [TL5.jl](https://ricardo-luis.github.io/me-2/TL5.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CSV = "~0.10.15"
DataFrames = "~1.7.0"
HTTP = "~1.10.17"
Plots = "~1.40.17"
PlutoTeachingTools = "~0.4.4"
PlutoUI = "~0.7.69"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "c0c77ad2fd0bf87c1dda9b07643197bea782e319"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "deddd8725e5e1cc49ee205a1964256043720a6c3"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.15"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "a656525c8b46aa6a1c76891552ed5381bb32ae7b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.30.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "0037835448781bb46feb39866934e243886d756a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "fb61b4812c49343d7ef0b533ba982c46021938a6"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.7.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4e1fe97fdaed23e9dc21d4d664bea76b65fc50a0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.22"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d55dffd9ae73ff72f1c0482454dcf2ec6c6c4a63"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.5+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "83dc665d0312b41367b7263e8a4d172eac1897f4"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.4"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3a948313e7a41eb1db7a1e733e6335f17b4ab3c4"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "7.1.1+0"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates"]
git-tree-sha1 = "3bab2c5aa25e7840a4b065805c0cdfc01f3068d2"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.24"
weakdeps = ["Mmap", "Test"]

    [deps.FilePathsBase.extensions]
    FilePathsBaseMmapExt = "Mmap"
    FilePathsBaseTestExt = "Test"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "301b5d5d731a0654825f1f2e906990f7141a106b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.16.0+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "1828eb7275491981fa5f1752a5e126e8f26f8741"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.17"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "27299071cc29e409488ada41ec7643e0ab19091f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.17+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "35fbd0cefb04a516104b8e183ce0df11b70a3f1a"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.84.3+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ed5e9c58612c4e081aecdb6e1a479e18462e041e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InlineStrings]]
git-tree-sha1 = "8594fac023c5ce1ef78260f24d1ad18b4327b420"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.4"

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

[[deps.InvertedIndices]]
git-tree-sha1 = "6da3c4316095de0f5ee2ebd875df8721e7e0bdbe"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.1"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eac1206917768cb54957c65a615460d87b455fc1"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.1+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "4f34eaabe49ecb3fb0d58d6015e32fd31a733199"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.8"

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
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a31572773ac1b745e0343fe5e2c8ddda7a37e997"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "4ab7581296671007fc33f07a721631b8855f4b1d"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.1+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "321ccef73a96ba828cd51f2ab5b9f917fa73945a"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

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
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.5+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "f1a7e086c677df53e064e0fdd2c9d0b0833e3f6e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.5.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2ae7d4ddec2e13ad3bddf5c0796f7547cf682391"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.2+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "275a9a6d85dc86c24d03d1837a0010226a96f540"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.3+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "3db9167c618b290a05d4345ca70de6d95304a32a"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.17"

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
git-tree-sha1 = "d0f6e09433d14161a24607268d89be104e743523"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.4"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "2d7662f95eafd3b6c346acdbfc11a762a2256375"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.69"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "eb38d376097f47316fe089fc62cb7c6d85383a52"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.8.2+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "da7adf145cce0d44e892626e647f9dcbe9cb3e10"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.8.2+1"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "9eca9fc3fe515d619ce004c83c31ffd3f85c7ccf"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.8.2+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "e1d5e16d0f65762396f9ca4644a5f4ddab8d452b"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.8.2+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "712fb0231ee6f9120e005ccd56297abbc053e7e0"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.8"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "2c962245732371acd51700dbb268af311bddd719"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.6"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "725421ae8e530ec29bcbdddbe91ff8053421d023"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.1"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "f2c1efbc8f3a609aadf318094f8fc5204bdaf344"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "372b90fe551c019541fafc6ff034199dc19c8436"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.12"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "6258d453843c466d84c17a58732dda5deeb8d3af"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.24.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    PrintfExt = "Printf"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"
    Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "af305cc62419f9bd61b6644d19170a4d258c7967"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.7.0"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "9caba99d38404b285db8801d5c45ef4f4f425a6d"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.1+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "c5bf2dad6a03dfef57ea0a170a1fe493601603f2"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.5+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4bba74fa59ab0755167ad24f98800fe5d727175b"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.12.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
"""

# ╔═╡ Cell order:
# ╟─2c8630b8-91e2-4563-814d-7d310cffb4ef
# ╟─ed32cd37-3b8b-439a-9c96-ca7da5e7a061
# ╟─f86aa1d6-ff9a-49b5-93af-2dd91a0a8781
# ╟─73edb666-0186-4298-a61d-c708c77e9010
# ╟─d41f2f9e-a0e7-4a1f-a958-cd8f5ba7ffe5
# ╠═cb9cd8b4-421c-4081-bceb-74525f3eeadd
# ╠═cd6d3267-4cf1-436f-aeaf-f37f48ca1eab
# ╟─58642ad2-3aeb-4c55-ac3a-0cd1cd7bfaaf
# ╠═e51a2abf-e00d-4b80-aee4-9a740a8d8244
# ╟─ae2dd8d9-7774-42d9-8daa-de671c778558
# ╠═d88fe3ad-5896-412a-81dd-8bc94a03b64c
# ╟─a16531f0-3acc-4a5e-a3cd-7285bf131687
# ╟─2324d582-e948-40d9-a5ca-e7af0c5d9321
# ╠═05dc1b9c-d8ee-4025-8461-e6d799e158f0
# ╟─98c0b6ff-f4aa-43c4-819e-d27dcb08d3be
# ╟─59d46295-7090-4ccf-b916-b79e99dfd730
# ╟─4e175b3c-b247-4502-b8a0-8e30d652f611
# ╠═b2d7ea8b-4e7b-4a66-b070-fd06db7c4ee8
# ╟─6161d57a-030f-4c47-8b35-41b1425146d4
# ╟─a468e6c6-8987-41dd-adfc-27f9c37e297c
# ╟─4d4e1abb-7063-4da4-b3a8-038499a94f97
# ╟─0ac3d670-a191-49e5-9242-e06e2230d8dc
# ╠═b7c67c72-bf87-4e5d-8169-1fe73e977f9d
# ╠═3dc2f1ac-cdd0-460c-803f-47b6e91fc618
# ╟─663dee2f-75f6-4923-8c21-fc9daac8d095
# ╟─a8740a11-78f2-418f-94fe-b98fde0ef992
# ╟─d77d021c-7d48-43ce-8ea4-4e2571bd1491
# ╠═62c2eb5f-8e77-4f9d-89df-e76bf3466d05
# ╠═cdbe0d0c-ce72-405f-a80a-a52df24c6c03
# ╠═66a50cc3-7bea-45d0-908f-b12c529e82f2
# ╠═5098a9ca-89f7-4f6d-8bfc-9eb18110e176
# ╟─4aaf3368-5614-4aef-ae4a-400efcf74895
# ╠═881564ee-5219-451f-8346-658f0aa4972f
# ╟─e04c6791-658c-495f-92d9-0988bfad036e
# ╠═c7773506-b308-431d-adb2-0c55c72e8879
# ╠═fb684796-9a16-41f2-bfe4-a4cb9160c265
# ╠═8e400126-63be-41db-b264-f3bbc7cda806
# ╟─07fe612f-3742-4d1b-bc90-c1fdf8bab30f
# ╟─b6805114-cac1-4866-ba9e-312946b7feb4
# ╠═a0e94996-dc43-4967-bda2-7cc9498a1eeb
# ╠═bb9916c2-47ee-403b-8382-ef41fbca57c3
# ╠═058f892b-1705-4821-bd6c-813fc6f30a78
# ╠═4193cb25-de59-49bb-a329-4c173ca18f8e
# ╠═1ba364ee-8920-4a9f-ad36-29d882f560eb
# ╠═488a36a0-fef6-475d-9f69-56801f0059f7
# ╟─fe4db7cb-f5fb-48d5-a26c-241a153ac55d
# ╟─e8dece0d-9a75-4e67-80ff-118603691c1e
# ╟─6c48f0d5-70cb-4cfa-80a2-2a3f2f5e84b1
# ╟─22598e72-fd83-4556-8a83-d1f32b919585
# ╟─3ea09b6d-e0a3-44fd-a0fa-99d4c6933321
# ╠═af146314-12f3-4e2c-a8cd-86e9f487e012
# ╟─c447185a-f13d-4d11-8233-1f572db1f917
# ╟─a8708162-de5d-4681-a23c-1c1019e9e3a5
# ╟─f917bfd2-d302-4845-88b3-fbf2127c054a
# ╠═ca9b9f44-bd2b-4baa-911c-ed2f09c009a0
# ╟─9c9af988-29f2-4bc6-b03f-56e694c27de3
# ╟─ba7bd9cf-44b4-40b5-a1d3-159f599e998f
# ╠═43749024-ed93-41b0-9f62-e458e2abcfd5
# ╟─0d3b2041-9633-44bf-a09f-0d0626205826
# ╠═169ab7ab-14b1-4997-889c-6e7e1ff80147
# ╠═bd79a7d7-edbf-45c7-8b01-6c60838f623d
# ╟─22e5c592-cd81-430f-8fab-34f3cec588ca
# ╟─43a89c9e-85a1-49f9-852f-b02fed01dd0c
# ╟─3d129e5b-cb06-47b0-9490-f8391a9d120c
# ╠═df3ba2f9-aaf4-4579-89ad-69113ce5dc8e
# ╠═a9c02270-4c71-490a-928f-d465e8764576
# ╠═3ce227cc-37a2-4cd0-be06-d90e1cb23e0b
# ╠═8a565e25-34f2-459d-819f-c88cbc6d9c15
# ╟─1660096b-1f6f-426c-8a4b-5ab59e17bc10
# ╟─d365359b-6759-44c3-bf09-c35dadd62b29
# ╠═14584720-6811-4774-9fc0-54ce524c89c4
# ╠═258ecb33-9396-4d9c-afe4-871fd165b014
# ╟─866265b0-4c95-41ee-ad33-828868cf7fa9
# ╟─3355f4d0-fc6f-4b2c-88a3-79e2a3f93b60
# ╠═7d7befd2-5c57-401e-aa11-c922b301a6cf
# ╠═2c36c4b8-6fd9-4c7e-b448-b723c9845fbd
# ╟─e007c3d9-19d6-4184-8389-8da9e9c43f6f
# ╟─72d27ac6-ada4-42ed-8639-a5cfdba36283
# ╠═3f20fbab-1649-4e64-ad67-82e68e9995ca
# ╟─7f3d23eb-66c6-4bdd-a777-87f165464b49
# ╠═fb5393a1-fca2-4512-bf78-1a36d61f99f5
# ╠═3ade6db8-8f2b-4de2-b981-038fe785d091
# ╟─425b6829-9b2f-4fdd-be67-aeed6daade64
# ╟─b37b67e2-b6c8-40d4-8a2c-0e67b4f9baa4
# ╠═168fcba2-8cdb-4265-97b2-8e5911b06867
# ╟─cf19d614-6eef-423d-8844-6c845dcfa352
# ╟─2f25d04e-f1d4-413d-88fc-ccc005aabf06
# ╠═e4b18448-f22c-469a-9ebf-2b9ebeaae1e5
# ╠═3fbd3f6e-6a41-4218-9eef-2f83a15f2a58
# ╟─e8d9674b-2805-49f9-ad69-8c53e43a6788
# ╠═8bccbf30-89a0-4561-86d4-06d788a7d29f
# ╠═029b40b9-dbec-4123-88c1-2eb34e842a79
# ╠═580feaab-480a-40ee-871c-fa6fd8d66e7b
# ╠═37b550c6-60d3-49ef-90fb-cde7a868d744
# ╠═53e373f3-1cfd-49c5-ad0c-409c1e9bb6f1
# ╠═6a843590-dd2b-405e-b0dd-249254c9dd93
# ╟─d9c5c3b6-1879-4dd5-b4c0-6ba182883577
# ╠═fda4d4b4-c824-4f27-81e8-80f323643be9
# ╠═67004f21-139f-4535-b637-2b28b9762a1a
# ╠═015c0c72-e797-40b9-8cc4-102a0bec4445
# ╟─7276a59b-8d1e-4cd5-9aaa-827688769bdd
# ╟─6af3525f-4738-453d-99ab-e492fc015315
# ╠═23d66072-6000-4e23-85e1-546310bdff73
# ╠═89bbcfcb-cd64-430c-a27c-d9196bd6a89f
# ╠═14eeae09-0570-4fb5-a320-cbf8dca52f4b
# ╠═a275790e-6310-4151-a6db-f67c79b94766
# ╠═c36c0a70-4159-4b96-8d81-463fd0a214cc
# ╟─275ef195-f335-48eb-9c4e-2c5d27379d01
# ╠═294e716b-31a0-4c27-8d9f-b1fe16c8debd
# ╠═bc17b1d4-3fef-4e50-9527-74497fd925a7
# ╠═5fa9acdd-0307-45ca-a91a-b8216e4bf73d
# ╟─de949862-efbc-44a6-b95b-103c630e967a
# ╟─cb30455b-5fb5-4125-af4a-d5a3be97fcf5
# ╠═378527c4-a316-423b-8ef7-6f5a5e8b81e6
# ╠═564ac000-a2b6-44f8-a8be-1d73917bbaf3
# ╠═5c9ede2a-a671-4a56-ba53-8a38c5f7ec8c
# ╠═a8caebc7-13e9-470c-90a7-c6f0797bbd78
# ╟─0f8411f9-ba0f-4d53-aed8-d0a60a8adda0
# ╟─7bb1e678-2b40-46f5-a94b-4021195285e1
# ╟─d4ed5f43-3a6d-40ca-bfc8-869938789d7e
# ╠═bbb73813-b32d-4440-baf0-0a8ef335accb
# ╟─8a2c8df3-765b-43bd-96ae-916485758339
# ╠═7fc592b2-1df6-4b31-9bc5-0724d1d384d8
# ╟─020ebbaf-5914-47d8-82f7-7f948e2903ad
# ╟─4056b29c-37ca-4c06-a75e-2beb8cda7beb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
