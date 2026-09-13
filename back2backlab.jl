### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["lecture", "module2"]
#> title = "Ensaio back-to-back"
#> description = "Este notebook documenta o relatório laboratorial de um ensaio back-to-back em máquinas de corrente contínua (CC), realizado com um grupo motor-gerador mecanicamente acoplado e eletricamente ligado em paralelo a uma rede CC. Este método permite analisar o balanço de potências, avaliar as perdas e determinar o rendimento das máquinas em diferentes condições de funcionamento."
#> chapter = 1
#> section = 6
#> image = "https://github.com/Ricardo-Luis/me-2/blob/276c849a55a685a43c1b3e7d97355f648664d3a9/images/card/back2back.svg?raw=true"
#> layout = "layout.jlhtml"
#> date = "2026-09-11"
#> order = 6
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

# ╔═╡ e89303b7-3dbb-452c-bd71-ddaac5d22dc4
using PlutoUI, PlutoTeachingTools, Plots, EasyFit, PrettyTables, Statistics, BasicInterpolators, SankeyPlots
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - EasyFit.jl, interface for obtaining curve fitting of 2D data
  - PrettyTables.jl, print data in matrices in a human-readable format (tables)
  - Statistics.jl, for basic statistics functionality
  - BasicInterpolators.jl, provides interpolation methods
  - SankeyPlots.jl, provides a Plots.jl recipe for Sankey diagrams
=#

# ╔═╡ 1aceb22f-57fe-4428-bbd7-3410a10e269e
TwoColumnWideLeft(md"`back2backlab.jl`", md"`Last update: 11·09·2026`")

# ╔═╡ c064e55c-6924-49b7-abbc-385a081c57b2
md"""
---
$\text{RELATÓRIO}$ 

$$\begin{gather}
\colorbox{Bittersweet}{\textcolor{white}{\textbf{Ensaio \emph{back-to-back} :}}} \\
\colorbox{Bittersweet}{\textcolor{white}{\textbf{Análise de potências, perdas e rendimento de máquinas CC}}}
\end{gather}$$
---
"""

# ╔═╡ 01d6ccf1-a046-4386-95b9-7a8437e6bc48
md"""
# 1 - Introdução
"""

# ╔═╡ aa438d59-98d7-41b6-b34d-aa55220cf04f
md"""
## 1.1 - Objetivos
"""

# ╔═╡ 57972b14-d0eb-49f2-a8fe-fbfa25eb2f43
md"""
- Compreender o ensaio *back-to-back*;
- Ligar eletricamente máquinas de corrente contínua (CC) em paralelo;
- Estabelecer o balanço de potências de uma máquina CC (gerador e motor);
- Determinar curvas de rendimento das máquinas CC.
"""

# ╔═╡ dcfb10ac-3a34-477f-ae1e-6a4b42fdc0d2
md"""
## 1.2 - Ensaio *back-to-back*
"""

# ╔═╡ 5d618284-7f40-4d33-94a1-829407bd5f47
md"""
O ensaio *back-to-back* de máquinas elétricas CC consiste em associar em paralelo um grupo motor-gerador (mecanicamente acoplados), ligados eletricamente a uma rede CC, como apresentado no esquema de ligações, [^Fig_2_1].

O funcionamento do grupo CC motor-gerador no ensaio *back-to-back* pode resumir-se nos seguintes passos:
- Após o arranque do motor este alimentará mecanicamente o gerador;
- O gerador é ligado à rede CC, após verificação das condições de paralelo;
- A regulação da corrente de excitação do gerador, $I_{ex}^G$, permite regular a potência elétrica que o gerador fornece à rede CC, carregando mecanicamente o motor;
- Em simultâneo, o motor absorve a potência elétrica produzida pelo gerador;
- Como os processos de conversão eletromecânica de energia nas máquinas têm perdas, a potência absorvida pela rede CC corresponderá ao somatório das perdas existentes no grupo motor-gerador.
"""

# ╔═╡ 07eeed4a-6a40-4585-b04f-26da0157fe2e
Foldable("Listagem das grandezas utilizadas neste relatório:",md"
-  $$U, I$$: tensão, corrente da rede CC\
-  $$p_t$$: perdas totais do sistema *back-to-back*\
-  $$R_i^M, R_i^G$$: resistências rotórica do motor e gerador, velocidade do grupo motor-gerador\
-  $$I_l^M, I_l^G$$: correntes de linha do motor e gerador\
-  $$P_{ab}^M, P_{ab}^G$$: potências absorvidas do motor e gerador\
-  $$I_{ex}^M, I_{ex}^G$$: correntes de campo do motor e gerador\
-  $$p_J^M, p_J^G$$:  perdas de Joule no induzido do motor e gerador\
-  $$p_{ex}^M, p_{ex}^G$$:  perdas de excitação (em derivação) do motor e gerador\
-  $$p_{ele}^M, p_{ele}^G$$:  perdas elétricas do motor e gerador\
-  $$p_{C}^M, p_{C}^G$$:  perdas constantes do motor e gerador\
-  $$P_d^M, P_d^G$$: potências desenvolvidas do motor e gerador\
-  $$T_d^M, T_d^G$$: binários desenvolvidos do motor e gerador\
-  $$p^M_{(mec+Fe)}=p^G_{(mec+Fe)}=p_{(mec+Fe)}$$: as perdas mecânicas e magnéticas, ou perdas rotacionais, $$p_{rot}$$, das máquinas consideram-se iguais, dado que as máquinas têm dimensões/características semelhantes\
-  $$T_d^M=T_d^G=T_d$$: também se conclui que os binários desenvolvidos são iguais, $$T_d=T_u+\frac{p_{rot}}{ω_m}$$ \
-  $$T_u, ω_m$$ ou $$n$$: binário mecânico, velocidade angular mecânica do grupo motor-gerador em $$\rm rads^{-1}\:$$ ou $$\:\rm rpm$$, respetivamente\
-  $$P_{u}^M, P_{u}^G$$: potências úteis do motor e gerador\
-  $$E^{'},E$$: força contra-eletromotriz do motor, força eletromotriz do gerador\
")

# ╔═╡ 1eb4379f-2d29-4dea-b6c5-cd2f81ed8381
aside((md"""
!!! info "Informação"
	👈 clicar em ▶ / ▼ para expandir/comprimir
"""), v_offset=-110)

# ╔═╡ 184d5409-76fa-4970-9da7-6d8c8bd79713
md"""
Seguindo o raciocício sobre o princípio de funcionamento do sistema *back-to-back*, a potência mecânica absorvida pelo gerador, $P_{ab}^G$, corresponde à potência útil do motor, $P_{u}^M$, $(1.2)$.   

Em $(1.1)$ e $(1.3)$ estabelecem-se os balanços de potências para o motor e gerador, respetivamente.

Substituindo $(1.1)$ em $(1.2)$ e recombinando com $(1.3)$ obtém-se $(1.4)$, mostrando que a diferença entre $P_{ab}^M$ e $P_{u}^G$, corresponde ao somatório das perdas do grupo motor-gerador.

Assim, o somatório das perdas corresponde à potência absorvida da rede CC, traduzida em $(1.5)$ e $(1.6)$.

As perdas elétricas do motor e gerador, $P_{el}^M$ e $P_{el}^G$, respetivamente, são determinadas pelo conhecimento dos seus circuitos induzidos e indutores (resistências, tensões e correntes).

Sobram as perdas mecânicas e do ferro, ou perdas rotacionais, de cada máquina CC. Se as máquinas a ensaiar tiverem dimensões e potências semelhantes, então assume-se os mesmo valor de $p_{rot}$ para ambas, $(1.7)$, resultando $(1.8)$. 

Caso tal não se verifique, uma possibilidade consiste em tomar uma ponderação que relacione a potência nominal de cada uma das máquinas CC, atribuindo um peso correnpondente, para o cálculo da perdas rotacionais.

Determinadas todas as perdas é exequível a análise de potências, perdas e rendimento das máquinas CC ensaiadas.
"""

# ╔═╡ f8de4a5c-64a2-49c4-88e2-c26c843b1fc1
md"""
$\begin{align}
\tag{1.1}
P_{ab}^M - p_J^M - p_{ex}^M - p_{rot}^M &= P_{u}^M \\

\tag{1.2}
P_{u}^M &= P_{ab}^G \\

\tag{1.3}
P_{ab}^G &= P_{u}^G + p_J^G + p_{ex}^G + p_{rot}^G \\

\tag{1.4}
P_{ab}^M - P_{u}^G &= p_J^M + p_{ex}^M + p_{rot}^M + p_J^G + p_{ex}^G + p_{rot}^G \\

\tag{1.5}
p_t &= p_{el}^M + p_{el}^G + p_{rot}^M + p_{rot}^G \\

\tag{1.6}
P_{ab}^M - P_{u}^G &= p_t = U I \\

\tag{1.7}
p_{rot}^M &\approx  p_{rot}^G \\

\tag{1.8}
p_{rot} &= \frac{1}{2} (p_t - p_{el}^M - p_{el}^G) \\
\end{align}$
"""

# ╔═╡ 39721ee5-b4f8-47ed-ae4f-0865952ebd28


# ╔═╡ 3010fa73-fdb8-4ad9-94dc-45db49ae7fcf
md"""
# 2 - Procedimento de ensaio
"""

# ╔═╡ f60d6cdd-7ff4-4a00-b2aa-a1440234ec6d
md"""
## 2.1 - Esquema de ligações
"""

# ╔═╡ 5f0b7230-28eb-4394-981f-0974e49284a3
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:
	raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/back2backlab/scheme.drawio"

# viewer_url build:
	viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1#U" * raw_url

# HTML:
HTML("""
<iframe frameborder="0" style="width:100%;height:700px;" 
        src="$(viewer_url)">
</iframe>
""")
end

# ╔═╡ 127a7dbf-88fe-4b28-a265-7bf315850497
md"""
[^Fig_2_1]: Esquema de ligações do ensaio *back-to-back*.
"""

# ╔═╡ c387e50c-5aac-4901-b1f3-51b690c38a56
md"""
## 2.2 - Material utilizado
"""

# ╔═╡ dfa54345-bcae-4350-aa43-72cd62b83d65
md"""
**Bancada n.º3**

Máquinas CC de excitação composta (utilizadas em excitação derivação): Elektromotoren Werke Kaiser (fabricante) 

- Motor CC n.º 951 (5.5kW; 1500rpm; 220V; 29A):

| **V** | **A** | **kW** | **rpm** |
|:-----:|:-----:|:------:|:-------:|
|  178  |   29  |   4.4  |   1200  |
|  220  |   29  |   5.5  |   1500  |
|  220  |   29  |   5.5  |   2000  |
|       |       |        |         |
|  220  | 0.59 ... 0.35A | (excit.) |

		
- Gerador CC n.º 942 (4.0kW; 250V; 16A; 1500rpm):

| **V** | **A** | **kW** | **rpm** |
|:-----:|:-----:|:------:|:-------:|
|  195  |   16  |   3.1  |   1200  |
|  250  |   16  |   4.0  |   1500  |
|  345  |   16  |   5.5  |   2000  |
|       |       |        |         |
|  250  | 0.3 | (excit.) |


**Reostatos**
- Reóstato de arranque: 7.5Ω
- Reóstato de campo (motor CC): 750Ω
- Reostáto de campo (gerador CC): 1100Ω


**Equipamento de medida**

- 2 amperímetros (circ. de excitação): Chauvin Arnoux C.A 401; Calibre: 1A
- 3 pinças amperimétricas: Chauvin Arnoux F03
- 3 voltímetros: Chauvin Arnoux C.A 402; Calibre: 300V
- taquímetro: Chauvin Arnoux C.A 25
- ponte de Wheatstone: Cropico Test


"""

# ╔═╡ 59b3486d-61cd-43ac-ae1c-4bd04ab5dd40


# ╔═╡ eb5f4190-17a0-4bac-b2a2-1d35622f3d2c
md"""
## 2.3 - Condução do trabalho
"""

# ╔═╡ fce78f7b-dcdc-4ae3-918d-622db2f27269
md"""
**Tempo de realização da montagem e execução do ensaio:** cerca de 75 minutos. 
\
1. Realizar a montagem elétrica de acordo com o esquema de ligações, [^Fig_2_1], com:

  - reóstato de arranque no valor máximo ⟹ corrente de arranque baixa;
  - reóstato de campo do motor no valor mínimo ⟹ velocidade baixa;
  - reóstato de campo do gerador no valor máximo ⟹ tensão baixa;
  - interruptores da montagem elétrica desligados inicialmente.
\
2. Ligar rede CC do Lab. de Máq. Elétricas e na bancada de ensaio $(U_{rede}=220\rm{V})$. Ligar o interruptor, $\rm IF1$, fazendo arrancar o motor CC;
\
3. Diminuir suavemente o reóstato de arranque até ao valor mínimo, $(0\Omega)$;
\
4. Ajustar a velocidade do grupo motor-gerador CC através do reostato de campo do motor para a velocidade nominal, $(n=1500\rm{rpm})$;
\
5. Ajustar a tensão do gerador CC, $(U_{ger}=220\rm{V})$, através do seu reóstato de campo. Confirmar a correta polaridade dos terminais gerador CC, relativamente aos terminais da rede CC. Fechar o interruptor, $\rm IF2$. Poderá verificar-se uma corrente de linha do gerador CC residual, devido a diferença de aferição entre o voltímetro do gerador *vs.* voltímetro na entrada da rede CC da bancada;
\
6. Dá-se início ao registo de valores do ensaio *back-to-back*:

   - Para regular a carga das máquinas, de modo a criar vários pontos de funcionamento do grupo motor-gerador com potências em jogo sucessivamente crescentes, diminui-se progressivamente o reóstato de campo do gerador CC e reajusta-se a velocidade para o valor nominal, através do reóstato de campo do motor CC;

   - Registam-se sucessivamente os valores das correntes de linha e de exitação de cada máquina CC, a corrente na entrada da rede CC e a velocidade, para os diferentes pontos de funcionamento do grupo motor-gerador. A tensão será constante. 
\
7. Repetir ponto 5 (exceto a condição de polaridade). Desligar os interruptores por ordem inversa. Fim de ensaio.\

"""

# ╔═╡ 6fef9e1c-e321-4ef8-9140-dc4dbfe49936


# ╔═╡ 349d542f-024d-4982-867c-afa9e105db27
md"""
# 3 - Resultados experimentais
"""

# ╔═╡ f1b48849-a61f-4825-bcc8-ff12d3c09987
md"""
## 3.1 - Leituras realizadas
"""

# ╔═╡ e05493c5-1231-4fda-821c-65420c221551
md"""
Tensão da rede de corrente contínua:
"""

# ╔═╡ 5bb9b54a-56f3-431c-b47c-75a58bff7d22
U = 220; 			# DC grid voltage, V

# ╔═╡ 494278aa-f24d-4168-8615-f7803495fafd
md"""
Medição dos enrolamentos induzidos das máquinas CC:
"""

# ╔═╡ 080ba59a-6a4a-424e-8741-9b59332c2f86
begin
	Rᵢᴹ = 1.22 		# Armature resistance of the motor, Ω
	Rᵢᴳ = 2.02 		# Armature resistance of the generator, Ω
end;

# ╔═╡ 60cc12ac-6fe6-439b-a149-39ffa704ba8b
md"""
Dados registados ao longo do ensaio *back-to-back*:
"""

# ╔═╡ a41a8eeb-c2bf-4025-8a91-a5654ba69ca7
# test data:
begin
	I = [2.95, 3.15, 3.63, 4.71, 5.40, 6.91, 7.82, 8.64, 8.75, 10.70]  					# A₁ amperemeter data
	Iₗᴹ = [3.86, 6.00, 9.13, 14.10, 16.10, 20.83, 23.34, 24.79, 25.33, 29.30] 			# A₂ amperemeter data
	Iₑₓᴹ = [0.660, 0.660, 0.630, 0.580, 0.580, 0.580, 0.580, 0.605, 0.570, 0.600] 		# A₃ amperemeter data
	Iₗᴳ = [1.69, 3.57, 6.02, 9.91, 11.43, 14.42, 16.18, 16.95, 17.16, 19.38] 			# A₄ amperemeter data
	Iₑₓᴳ = [0.280, 0.275, 0.280, 0.285, 0.295, 0.320, 0.330, 0.370, 0.360, 0.390] 		# A₅ amperemeter data
	n = [1497, 1491, 1490, 1518, 1512, 1510, 1510, 1490, 1522, 1491] 					# Tachometer data
	I, Iₗᴹ, Iₑₓᴹ, Iₗᴳ, Iₑₓᴳ, n 
end;

# ╔═╡ d37297d1-3e7d-4a17-9169-6d9fe268f2c5


# ╔═╡ df5bc5cc-9d9d-41d7-9956-a5f9af31c4cf
md"""
## 3.2 - Apresentação dos dados de ensaio
"""

# ╔═╡ 13d6e0d9-2cb9-4125-a406-c4caa0d63719
md"""
Nesta secção apresentam-se os quadros relativos aos dados obtidos das leituras realizadas, Tabelas 1 e 2:
"""

# ╔═╡ cf35b99b-b280-4866-a0e2-0092167a55ba
md"""
**Organização dos dados de ensaio para construção das Tabelas 1 e 2:** 
"""

# ╔═╡ fdb1a1d4-fb0f-45ae-96ef-5c3b5bec7f69
# header of the table 1
header_b2b = [["Irede", "Imot", "Iₑₓmot", "Iger", "Iₑₓger", "n"],
			  ["(A)", "(A)", "(A)", "(A)", "(A)", "(rpm)"]];  

# ╔═╡ f202a1bf-aaf8-4115-98e9-eba0da1666e4
# header of the table 2
OthersHeader = [["tensão da rede CC", "resistência rotórica do motor", 
				 "resistência rotórica do gerador" ], ["(V)", "(Ω)", "(Ω)"]]; 		

# ╔═╡ bba03ae4-313e-4e3a-a367-73b1d28e733e
dados_b2b = [I Iₗᴹ Iₑₓᴹ Iₗᴳ Iₑₓᴳ n]; 		# data of the table 1

# ╔═╡ 22e2b92e-d1e2-4f4b-b61c-f4776976f216
OutrosDados = [U Rᵢᴹ Rᵢᴳ]; 					# data of the table 2

# ╔═╡ b1092f90-3d0b-4f5c-8d55-79a5a199b49f
pretty_table(HTML, dados_b2b, column_labels = header_b2b, alignment=:c, title = "Tabela 1: Leituras realizadas no ensaio back-to-back")

# ╔═╡ b74e6eae-d059-4409-b0cb-ba19475a53a0
pretty_table(HTML, OutrosDados, column_labels = OthersHeader, alignment=:c, title = "Tabela 2: Outros dados registados")

# ╔═╡ 7becf999-5f11-4a47-8e3f-2b775f52bd27


# ╔═╡ f0132080-ad3c-47d1-b0e3-c9c7994c072f
begin
	n_media = median(n)  			# arithmetic mean calculation
	n_media = round(Int, n_media)   # rounding to integer number 

	n_desvio = std(n)    			# standard deviation calculation
	n_desvio = round(Int, n_desvio)
	
	n_media, n_desvio   			# show statistical results
end

# ╔═╡ b32d55d7-80b2-45f1-abaf-ef8f6958e980
md"""
Por análise dos dados estatísticos da velocidade constata-se que o ensaio *back-to-back* foi realizado com uma velocidade aproximadamente constante, rondando o valor nominal de $$1500\rm rpm$$:

- **Média aritmética** = $(n_media) rpm

- **Desvio padrão** = $(n_desvio) rpm

"""

# ╔═╡ 71a60d6f-1527-4537-952d-b490af18a935
md"""
Assim, como a tensão das máquinas é contante (ambas ligadas à rede CC de $$220\rm V$$) e a velocidade é aproximadamente constante, perspectiva-se que as perdas rotacionais, $$p_{rot}$$, das máquinas sejam também aproximadamente constantes.
"""

# ╔═╡ 5bcefcd9-f30e-4b40-a1f0-b66ff862d963
begin
	Kirchhoff = I + Iₗᴳ - Iₗᴹ 				 
	Kirchhoffₘₐₓ = maximum(Kirchhoff)
	Kirchhoffₘₐₓ = round(Kirchhoffₘₐₓ, digits=1)
	
	Kirchhoff, Kirchhoffₘₐₓ
end

# ╔═╡ 6a7b7432-cb54-445a-aa39-33a13fb958ba
md"""
Aplicando a lei dos nós, ao nó $\textbf 1$ apresentado no esquema de ligações, [^Fig_2_1], verifica-se que as correntes medidas: $I$, $I_l^G$ e $I_l^M$, não verificam plenamente a 1ª lei de Kirchhoff, devido a diferenças de aferição entre os amperímetros utilizados, sendo o erro absoluto máximo das correntes medidas nesse nó de $(Kirchhoffₘₐₓ)A, ao longo do ensaio. 
"""

# ╔═╡ 81298eb8-b548-42aa-9fea-fa502482578b


# ╔═╡ 1931180b-424d-43ba-af25-61e84faf0eaf
md"""
# 4 - Análise de resultados
"""

# ╔═╡ 7e48b1e0-b66c-4773-9189-b72e931b8520
md"""
## 4.1 - Balanço de potências
"""

# ╔═╡ df08b5c7-d63b-430d-8869-a994ed85b73c
md"""
Na figura  [^Fig_2_2] apresenta-se o diagrama representativo do balanço de potências do ensaio *back-to-back*, com as relações de potências e perdas desta associação de máquinas elétricas de corrente contínua.
"""

# ╔═╡ 3a44a05d-68a4-4622-afd3-1b67e95c7088
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:
	raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/back2backlab/power_flow.drawio"

# viewer_url build:
	viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1#U" * raw_url

# HTML:
HTML("""
<iframe frameborder="0" style="width:100%;height:400px;" 
        src="$(viewer_url)">
</iframe>
""")
end

# ╔═╡ bc95d83c-fb07-4f24-b08a-b461d871c79e
md"""
[^Fig_2_2]: Balanço de potências do ensaio *back-to-back*.
"""

# ╔═╡ 404e5b4b-0ddc-45b0-a4af-e29618a501be
md"""
O diagrama do balanço de potências da [^Fig_2_2] permite perceber as conversões de potências que ocorrem no funcionamento das máquinas envolvidas, mas ainda não quantifica o valor de cada parcela relativa a potências e perdas de cada máquina.
"""

# ╔═╡ 2f7931fa-262f-4f76-8f4b-f28e26989a2b


# ╔═╡ 66ada8ac-6556-4d18-9cf3-cbdbf3f9bc69
md"""
## 4.2 - Cálculo de potências e perdas
"""

# ╔═╡ 01e08f32-9f91-41f9-b022-ad877864a784
md"""
**Perdas das máquinas CC:**
"""

# ╔═╡ d12d08d6-4c4c-4afc-b4e5-970f86a440e5
md"""
- Cálculo das perdas totais do grupo motor-gerador:
"""

# ╔═╡ 2b7754b3-44b3-4a09-99e2-4827afbacc64
pₜ = U * I

# ╔═╡ d777bcfb-ffad-4061-b86b-cf3f2709576d
pₜ[6]


# ╔═╡ 9c117644-13d3-4de3-a30b-e626df7d6815
md"""
- Cálculo das perdas por efeito de Joule no circuito **induzido** de cada máquina:
"""

# ╔═╡ fc62b652-0d92-49e4-ae27-fd04a6b1d8bd
begin
	pⱼᴹ = Rᵢᴹ * Iₗᴹ.^2
	pⱼᴳ = Rᵢᴳ * Iₗᴳ.^2
	pⱼᴹ, pⱼᴳ
end

# ╔═╡ dff17723-bba8-491f-af37-9119e4ff4445
md"""
- Cálculo das perdas por efeito de Joule no circuito **indutor** de cada máquina:
"""

# ╔═╡ 1c048c68-2a41-4710-9d5d-e092abbfc7d9
begin
	pₑₓᴹ = U * Iₑₓᴹ
	pₑₓᴳ = U * Iₑₓᴳ
	pₑₓᴹ, pₑₓᴳ
end

# ╔═╡ 55483f43-ca65-4775-a4b7-b824295ad34d
md"""
- Cálculo das perdas rotacionais (consideradas igualmente repartidas pelas máquinas CC):
"""

# ╔═╡ 4cda0d79-6a76-4529-b70e-4eb0bf9c2451
pᵣₒₜ = 0.5 * (pₜ - pₑₓᴹ - pⱼᴹ - pₑₓᴳ - pⱼᴳ)

# ╔═╡ 0865009d-6d80-452b-b9e5-74b424f9b3c3
begin
	pᵣₒₜᵃᵛᵍ = median(pᵣₒₜ)				# arithmetic mean
	pᵣₒₜᵈᵉᵛ = std(n)					# standard deviation
	pᵣₒₜᵛᵃʳ = pᵣₒₜᵈᵉᵛ * 100 / pᵣₒₜᵃᵛᵍ 	# percentage change
	(pᵣₒₜᵃᵛᵍ, pᵣₒₜᵈᵉᵛ, pᵣₒₜᵛᵃʳ) = round.((pᵣₒₜᵃᵛᵍ, pᵣₒₜᵈᵉᵛ, pᵣₒₜᵛᵃʳ), digits=1) # rounding of statistical results
end

# ╔═╡ 4643e926-67e5-4ac5-a332-1895b992b981
md"""
Como esperado as perdas rotacionais são aproximadamente constantes, apresentando uma pequena variação de $(pᵣₒₜᵛᵃʳ)%, ao longo do ensaio *back-to-back*, em relação ao valor médio de $(pᵣₒₜᵃᵛᵍ)W:
"""

# ╔═╡ 361b5bbe-2fcd-4f96-8488-c52d9b2dbea5
md"""
- Cálulo das perdas constantes do motor e do gerador:
"""

# ╔═╡ 863fe345-3a98-46d6-9112-78ee18635ffe
begin
	pcᴹ = pᵣₒₜ + pₑₓᴹ
	pcᴳ = pᵣₒₜ + pₑₓᴳ
	pcᴹ, pcᴳ
end

# ╔═╡ bf4807d5-6fbb-43bc-9be3-475b2ad6e0f6
md"""
- Cálulo da potência útil do motor:
"""

# ╔═╡ f7e7769e-9be0-41bb-900b-9034db833a5b
md"""
A potência útil do motor pode ser calculada vista do lado gerador, correspondendo à sua potência mecânica (potência absorvida):
"""

# ╔═╡ ad8fdc0f-4059-4bec-98a5-8b38b5a17fd0
Pᵤᴹ¹ = U * Iₗᴳ + pₑₓᴳ + pⱼᴳ + pᵣₒₜ

# ╔═╡ 7c45e9f8-de6b-4bf8-aa91-5b23a47f5d02
md"""
Visto do lado do motor:
"""

# ╔═╡ 5d25244c-7d05-43af-a6a5-69fdb52a253e
Pᵤᴹ² = U * Iₗᴹ - pₑₓᴹ - pⱼᴹ - pᵣₒₜ

# ╔═╡ 901eaef2-2cff-4131-b19c-b43a88b35b34
begin
	dif = Pᵤᴹ¹ - Pᵤᴹ² 			# difference in calculation formula
	difₘₐₓ = maximum(dif)		# maximum difference
	difₘₐₓ = round(difₘₐₓ, digits=1)
end;

# ╔═╡ 29c9a3a5-73a1-4daa-b492-178b97917258
md"""
A diferença de resultados deve-se a diferenças de aferição da aparelhagem de medida. A difereça absoluta no cálculo da potência útil do motor, não excede os $(difₘₐₓ) W, o que é bastante aceitável, considerando a potência nominal do motor ensaiado.
"""

# ╔═╡ 99f6a01a-4a46-43dd-8ef9-a614302e29af
aside((md"""
!!! tip "Proposta de atividade"
	Para os objetivos definidos neste relatório não é necessário, mas adicionalmente poderá determinar-se a evolução de outras potências e binários de ambas as máquinas no ensaio *back-to-back*.
	
	Assim, utilizando a célula para código Julia indicada (com as potências e binários em comentário), calcule e represente graficamente as seguintes potências e binários:

	- potência absorvidas do motor e gerador, $$P_{ab}^M$$ e $$P_{ab}^G$$
	- potências desenvolvidas do motor e gerador, $$P_d^M$$ e $$P_d^G$$
	- binários desenvolvidos do motor e gerador, $$T_d^M$$ e $$T_d^G$$
	- binário mecânico, $$T_u$$
	
	No final, analise comparativamente os resultados das potências e binários obtidos entre as máquinas CC.
"""), v_offset=20)

# ╔═╡ 076bd182-885d-4808-ba4a-9d125cd09957
md"""
### 4.2.1 - 💻 Potências e binários
"""

# ╔═╡ c4fd1d3b-9b18-48b3-a0fd-466fcb3e17ee
md"""
**Cálculos:**
"""

# ╔═╡ d780fb54-2677-481e-a228-478845fba613
#begin
	#Pabᴹ = 
	#Pabᴳ =  
	#
	#Pdᴹ = 
	#Pdᴳ = 
	#
	#Tdᴹ = 
	#Tdᴳ = 
	#
	#Tᵤ = 
#end

# ╔═╡ d65460a3-a703-44f6-aa42-a3dd47ae3034
md"""
**Gráficos:**
"""

# ╔═╡ 7bcd562e-970f-4614-94d0-41b8f47a5ff2
begin
	# Left plot:
	h1=plot(                  ylabel="Potências (kW)", xlabel="Corrente (A)",
			title="Motor vs Gerador")

	# Right plot:
	h2=plot(                  ylabel="Binários (Nm)", xlabel="Corrente (A)", 
			title="Motor vs Gerador")
	
	#Plot layout:
	plot(h1, h2, layout = (1, 2), size=(750,500))
end

# ╔═╡ 18159d33-d61e-44cc-9966-801f15b7f5d5


# ╔═╡ 51f8e7ee-868e-47d9-bfa5-4ac06f37d942
md"""
**Análise:**
      
    
    
    
    
.
"""

# ╔═╡ 95fdbbc4-b612-4512-9069-6110e41f9e9d


# ╔═╡ c771cef0-8fb8-4414-af8a-3e6512832d90
md"""
### 4.2.2 - 💻 Diagrama de Sankey
"""

# ╔═╡ 46273cec-629b-4a2f-ba2c-e354e5003adc
md"""
Um diagrama de Sankey permite visualizar o fluxo de dados entre dois ou mais estados ou dimensões num dado processo. A largura das barras/setas de cada estado é proporcional à taxa de fluxo nessa fase do processo. O diagrama de Sankey é especialmente útil para a visualização global de fluxos de energia ou de potência em processos industriais ou numa rede elétrica com diferentes fontes de energia, sendo os fluxos energéticos dirigidos a diferentes categorias de utilizadores de energia.

Em geral, os diagramas de Sankey formam grafos acíclicos dirigidos, ou seja, nenhuma das partes do diagrama forma um ciclo. Esta característica, à partida inviabilizaria a sua utilização para análise do balanço de potência neste ensaio, pois pela [^Fig_2_2], o balanço de potências do ensaio _back-to-back_ forma um ciclo.

No entanto, abrindo o ciclo, a representação do balanço de potências no diagrama de Sankey, através de uma ferramenta computacional interativa, permite visualizar a evolução das perdas e potências das máquinas elétricas utilizadas ao longo do ensaio _back-to-back_.\
Assim, verifica-se que:

$P_u^G(k)=P_{ab}^M(k)-p_t(k)$

com: $k \in \{1,2,3,...,10,\}$, correspondendo à ordem de ensaio na Tabela 1.

Ou seja, verifica-se no diagrama de Sankey, em qualquer momento, $k$, do ensaio _back-to-back_, que a potência útil do gerador, $P_u^G(k)$, é entregue ao motor, sendo-lhe adicionada uma potência elétrica proveniente da rede CC, que é igual ao somatório das perdas, $p_t$, relativas às máquinas elétricas em funcionamento.
"""

# ╔═╡ 50f9ef55-ec4d-4801-a7df-b755fcc9cdef
aside((md"""
!!! tip "Atividade interativa"
	👈 Através do _slider_ selecione o momento do ensaio realizado, $k$, e visualize interativamente ao longo do ensaio _back-to-back_, a evolução relativa entre as perdas e as potências das máquinas elétricas de corrente contínua no diagrama de Sankey.
"""), v_offset=30)

# ╔═╡ 80d0dbc9-9e4c-4270-9395-baec8974bdf2
md"""
Momento do ensaio _back-to-back_ (linha de dados da Tabela 1): $\quad k=$ $(@bind k PlutoUI.Slider(1:1:10, default=6, show_value=true))
"""

# ╔═╡ 994319d8-2e54-4edd-a6fb-cd8df9f9fcd7
md"""
**Matrizes de construção do diagrama de Sankey:**
"""

# ╔═╡ a11a242c-4672-4639-ad54-faa63d0a1cd1
names = ["pₜ", "Pabᴹ", "Pdᴹ", "Pᵤᴹ=Pabᴳ", "Pdᴳ", "Pᵤᴳ", "Pₑₗₑᴹ", "pᵣₒₜᴹ", "pᵣₒₜᴳ", "Pₑₗₑᴳ", "Pabᴹ-pₜ"];  # state names in the Sankey chart

# ╔═╡ 6873136d-76b9-41ee-a61f-2dd473ac8aca
src = [1, 2, 2, 3, 3, 4, 4, 5, 5, 6]; # sources (order number of state names) in the Sankey chart

# ╔═╡ b6d6d602-03f6-4d11-be10-631a3502ea40
dst = [2, 3, 7, 8, 4, 9, 5, 10, 6, 11];  # destiny of the flow in the Sankey chart

# ╔═╡ f5d3be1c-ccb1-43ec-8d5b-5afc631cb54b
weights = [pₜ[k], U * Iₗᴹ[k] - pₑₓᴹ[k] - pⱼᴹ[k], pₑₓᴹ[k] + pⱼᴹ[k], pᵣₒₜ[k], Pᵤᴹ²[k], pᵣₒₜ[k], Pᵤᴹ²[k]-pᵣₒₜ[k], pⱼᴳ[k]+pₑₓᴳ[k], Pᵤᴹ²[k]-pₑₓᴳ[k]-pⱼᴳ[k]-pᵣₒₜ[k],Pᵤᴹ²[k]-pₑₓᴳ[k]-pⱼᴳ[k]-pᵣₒₜ[k]] 		# flow weights on Sankey chart (from previous loss and power calculations)

# ╔═╡ e8e790c5-fd10-4797-8dbf-74cde9ac20a2
colors = palette(:seaborn_bright);  	# palette colors used in the Sankey chart
# from color schemes: https://docs.juliaplots.org/latest/generated/colorschemes/

# ╔═╡ fbb2ce7b-3a81-4c4e-b271-0f33819837a7
sankey(src, dst, weights; node_labels=names, label_position=:bottom, label_size=12, edge_color=:gradient, compact=:true, node_colors=colors, size=(1000,500))

# ╔═╡ 469dd7f7-dc57-4743-a844-714fa3952c8c


# ╔═╡ bbdfee6a-fd4d-4220-aadf-9ceba2415a75
md"""
## 4.3 - Curvas de rendimento
"""

# ╔═╡ 884beeaf-d196-4d9a-9088-a3b88ff5670e
md"""
Cálculo dos pontos de rendimento do motor CC:
"""

# ╔═╡ 69892e4e-821b-4efa-b7f5-26bdbb5d0f8a
begin
	ηᴹ = Pᵤᴹ¹./(U*Iₗᴹ)
	ηᴹ = round.(ηᴹ*100, digits=1)		# percentage and rounding
end

# ╔═╡ 1658f96c-7d15-4ed2-9f58-a161bc8b635f
md"""
Cálculo dos pontos de rendimento do gerador CC:
"""

# ╔═╡ 3ad1607a-66c4-42e2-a088-db1832fd1f32
begin
	#ηᴳ=(U*Iₗᴳ)./(U*Iₗᴹ-pⱼᴹ-pₑₓᴹ-pᵣₒₜ) 	# other option!
	ηᴳ = (U*Iₗᴳ)./(Pᵤᴹ¹)
	ηᴳ = round.(ηᴳ*100, digits=1) 		# percentage and rounding
end

# ╔═╡ 49e3234a-c066-42bc-bc90-bf7699309286


# ╔═╡ 065d2711-a5b6-4fcd-8e99-919296af78cb
md"""
Cálculos auxiliares para determinação das linhas de tendência para o traçado das curvas de rendimento, perdas constantes e perdas variáveis calculadas, do motor e gerador, determinadas a partir dos dados de ensaio:
"""

# ╔═╡ 73632b98-0c48-41cd-a897-162363d8d3b9
begin
	# Calculation of the trend line for the motor efficiency curve:
	Iₗᴹ_m = hcat(Iₗᴹ)						# convert data vector to matrix
	ηᴹ_m = hcat(ηᴹ)							# convert data vector to matrix
	FIT_ηᴹ = fitexp(Iₗᴹ_m, ηᴹ_m, n=2)		# exponential trend line

	pcᴹ_m = hcat(pcᴹ)						# convert data vector to matrix
	FIT_pcᴹ = fitlinear(Iₗᴹ_m, pcᴹ_m)		# linear trend line

	pⱼᴹ_m = hcat(pⱼᴹ)						# convert data vector to matrix
	FIT_pⱼᴹ = fitquad(Iₗᴹ_m, pⱼᴹ_m)			# quadratic trend line

	# Calculation of the trend line for the generator efficiency curve: 
	Iₗᴳ_m = hcat(Iₗᴳ)						# convert data vector to matrix
	ηᴳ_m = hcat(ηᴳ)							# convert data vector to matrix
	FIT_ηᴳ = fitexp(Iₗᴳ_m, ηᴳ_m, n=2)		# exponential trend line

	pcᴳ_m = hcat(pcᴳ)						# convert data vector to matrix
	FIT_pcᴳ = fitlinear(Iₗᴳ_m, pcᴳ_m)		# linear trend line

	pⱼᴳ_m = hcat(pⱼᴳ)						# convert data vector to matrix
	FIT_pⱼᴳ = fitquad(Iₗᴳ_m, pⱼᴳ_m)			# quadratic trend line
end;

# ╔═╡ debd87f9-13ee-4177-8245-c9cc4df1d157


# ╔═╡ 2a0e3a6a-0fd0-4f9e-ab54-2377d0761ba3
md"""
**Gráfico de curva de rendimento do motor CC, $$\:\eta^M=f(I_l^M)$$, e relação com as perdas "constantes", $$\:p_C^M=f(I_l^M)$$ e as perdas variáveis, $$\:p_J^M=f(I_l^M)$$:**
"""

# ╔═╡ 26f2ef0d-bb46-4619-8ffe-98f3ac026269
begin
	# calculated efficiency points
	scatter(Iₗᴹ, ηᴹ, ylims=(70,90), ylabel="rendimento (%)", 
			right_margin = 5Plots.mm, bottom_margin = 5Plots.mm, mc=:orange, 
			legend=:topleft, label="ηᴹ, ensaio", size=(700,500))
	
	# trend line
	plot!(FIT_ηᴹ.x, FIT_ηᴹ.y, title="Motor CC", label="ηᴹ", lw=2) 				
	
	scatter!(twinx(), Iₗᴹ, pcᴹ, ylims=(0,800), xlabel="corrente de linha (A)", label=:none)
	plot!(twinx(), FIT_pcᴹ.x, FIT_pcᴹ.y, ylims=(0,800), legend=:bottomright,
			ylabel="perdas (W)", label="pcᴹ", ls=:dash, lw=2)
	
	scatter!(twinx(), Iₗᴹ, pⱼᴹ, ylims=(0,800), mc=:green, 
			xlabel="corrente de linha (A)", label=:none)
	plot!(twinx(), FIT_pⱼᴹ.x, FIT_pⱼᴹ.y, ylims=(0,800), legend=:topright,
			ylabel="perdas (W)", label="pⱼᴹ", ls=:dash, lw=2, lc=:green)
end

# ╔═╡ e9e3afa0-0b4d-4367-a7f9-acd8992a88a5


# ╔═╡ 1ee60c29-bb29-4d9c-a2d9-20fac192f89f
md"""
**Gráfico de curva de rendimento do gerador CC, $$\:\eta^G=f(I_l^G)$$, e relação com as perdas "constantes", $$\:p_C^G=f(I_l^G)$$ e as perdas variáveis, $$\:p_J^G=f(I_l^G)$$:**
"""

# ╔═╡ b4cf06cd-3872-4380-be18-7c90ae7f8b84
begin
	# calculated efficiency points
	scatter(Iₗᴳ, ηᴳ, ylims=(50,90), ylabel="rendimento (%)", 
			right_margin = 15Plots.mm, bottom_margin = 5Plots.mm, mc=:orange, 
			legend=:topleft, label="ηᴳ, ensaio", size=(700,500))

	# trend line
	plot!(FIT_ηᴳ.x, FIT_ηᴳ.y, title="Gerador CC", label="ηᴳ", lw=2) 		
	
	scatter!(twinx(), Iₗᴳ, pcᴳ, ylims=(0,800), xlabel="corrente de linha (A)", label=:none)
	plot!(twinx(), FIT_pcᴳ.x, FIT_pcᴳ.y, ylims=(0,800), legend=:bottomright,
			ylabel="perdas (W)", label="pcᴳ", ls=:dash, lw=2)
	
	scatter!(twinx(), Iₗᴳ, pⱼᴳ, ylims=(0,800), mc=:green, 
			xlabel="corrente de linha (A)", label=:none)
	plot!(twinx(), FIT_pⱼᴳ.x, FIT_pⱼᴳ.y, ylims=(0,800), legend=:topright,
			ylabel="perdas (W)", label="pⱼᴳ", ls=:dash, lw=2, lc=:green)
end

# ╔═╡ 6c2bab0b-4785-413b-a851-0c0ab06c73a4


# ╔═╡ 830796ba-f8d6-4843-9297-e76492589d49
begin
	(pcᴹᵃᵛᵍ, pcᴳᵃᵛᵍ) = median.((pcᴹ, pcᴳ))				# arithmetic mean
	(pcᴹᵈᵉᵛ, pcᴳᵈᵉᵛ) = std.((pcᴹ, pcᴳ))					# standard deviation
	# rounding of statistical results:
	(pcᴹᵃᵛᵍ, pcᴳᵃᵛᵍ, pcᴹᵈᵉᵛ, pcᴳᵈᵉᵛ) = round.((pcᴹᵃᵛᵍ, pcᴳᵃᵛᵍ, pcᴹᵈᵉᵛ, pcᴳᵈᵉᵛ), digits=1) 

	# Percent variation:
	pcᴹᵥₐᵣ = pcᴹᵈᵉᵛ * 100 / pcᴹᵃᵛᵍ
	pcᴳᵥₐᵣ = pcᴳᵈᵉᵛ * 100 / pcᴳᵃᵛᵍ
	(pcᴹᵥₐᵣ, pcᴳᵥₐᵣ) = round.((pcᴹᵥₐᵣ, pcᴳᵥₐᵣ), digits=1)
	
	# Presentation of results:
	Text("Perdas constantes do motor CC, (média aritmética, desvio padrão) W:"), (pcᴹᵃᵛᵍ, pcᴹᵈᵉᵛ),  Text("Perdas constantes do gerador CC, (média aritmética, desvio padrão) W:"), (pcᴳᵃᵛᵍ, pcᴳᵈᵉᵛ) 
end

# ╔═╡ 1e3c4060-5d78-4159-bb2d-caf158d9a32d
md"""
Verifica-se apesar dos ligeiros declives, que as perdas "constantes" do motor e do gerador são efetivamente aproximadamente constantes, apresentando uma variação em relação ao valor médio, de $(pcᴹᵥₐᵣ)% e $(pcᴳᵥₐᵣ)%, respetivamente. 
"""

# ╔═╡ 5ea61cf4-4f87-43ef-8556-f37ea60d2515


# ╔═╡ c870e56a-cc10-4f85-9767-af46d9845b6a
md"""
### 4.3.1 - Rendimento nominal
"""

# ╔═╡ d9063387-a1d9-44e5-81e8-9dd4111ad72a
md"""
Consultando as curvas de rendimento do motor e do gerador, para as respectivas correntes nominais, obtêm-se os seguintes rendimentos nominais:
"""

# ╔═╡ 0a699f92-004d-4a44-aae6-7fc0e9aad041
# Computational way to read nominal efficiencies:
begin
	(Iₙᴹ, Iₙᴳ) = (29, 16)							# rated current, A
	
	ηᴹ_I = LinearInterpolator(FIT_ηᴹ.x,FIT_ηᴹ.y)  	# trend line linear interpolation
	ηₙᴹ = ηᴹ_I(Iₙᴹ)									# rated efficiency, motor
	ηₙᴹ = round(ηₙᴹ, digits=1)

	ηᴳ_I = LinearInterpolator(FIT_ηᴳ.x,FIT_ηᴳ.y)
	ηₙᴳ = ηᴳ_I(Iₙᴳ)
	ηₙᴳ = round(ηₙᴳ, digits=1)

	Text("ηₙᴹ = $(ηₙᴹ)%"), Text(" 	ηₙᴳ = $(ηₙᴳ)%")	# presentation of results
end

# ╔═╡ 36ce1f19-59f6-4595-a75a-22f519e326d9


# ╔═╡ c674d531-be5a-45b6-b5be-480753f0135f
md"""
### 4.3.2 - Rendimento máximo
"""

# ╔═╡ 28563a65-dfbd-4143-a0ec-772e553a3fb9
md"""
Forma computacional para obtenção dos pontos de rendimento máximo, nas curvas, $$\:\eta^M=f(I_l^M)$$ e $$\:\eta^G=f(I_l^G)$$, (optativo em relação a uma leitura direta dos gráficos obtidos): 
"""

# ╔═╡ 97a33323-b7ae-4aa7-b2c1-a8f302694f62
begin
	index1=argmax(FIT_ηᴹ.y) 	# find the position in the vector where the value is maximum
	ηₘₐₓᴹ=FIT_ηᴹ.y[index1]		# get maximum efficiency
	ηₘₐₓᴹ=round(ηₘₐₓᴹ, digits=1)
	I1=FIT_ηᴹ.x[index1]			# current value corresponding to maximum efficiency
	I1=round(I1, digits=1)
	
	index2=argmax(FIT_ηᴳ.y) 	# find the position in the vector where the value is maximum
	ηₘₐₓᴳ=FIT_ηᴳ.y[index2]		# get maximum efficiency
	ηₘₐₓᴳ=round(ηₘₐₓᴳ, digits=1)
	I2=FIT_ηᴳ.x[index2]			# current value corresponding to maximum efficiency
	I2=round(I2, digits=1)
	
	Text("Ponto de rendimento máximo do motor CC: $(ηₘₐₓᴹ)% @ $(I1)A"),
	Text("Ponto de rendimento máximo do gerador CC: $(ηₘₐₓᴳ)% @ $(I2)A")
end

# ╔═╡ e40a1b59-ed60-4081-afbf-661373b8b3fa
md"""
Da análise às curvas de rendimento das máquinas CC, verificam-se os seguintes pontos de rendimento máximo:

- Gerador: $$\:\:I_l^G(\eta_{max}^G) =$$ $(I2) $$\rm A; \it \quad\eta_{max}^G =$$ $(ηₘₐₓᴳ) $$\rm\%$$
- Motor: $$\quad I_l^M(\eta_{max}^M) =$$ $(I1) $$\rm A; \it \quad\eta_{max}^M =$$ $(ηₘₐₓᴹ) $$\rm\%$$
"""

# ╔═╡ 291e034f-a119-4c9b-8a50-4a35cd54e055
md"""
Comparando os pontos de rendimento máximo obtidos, do motor e do gerador, relativamente às respetivas perdas, verifica-se uma boa aproximação ao esperado dos conceitos teóricos sobre análise de rendimento de máquinas elétricas, em que o rendimento máximo se verifica quando as perdas variáveis são iguais às perdas contantes. 

Alguma divergência nos valores encontrados, como apontado anteriormente, podem ser justificadas pela  diferença de aferição dos aparelhos de leitura utilizados, as pequenas variações de velocidade do grupo motor-gerador ao longo do ensaio e as perdas "constantes" na prática, apresentarem algum declive, ainda que pouco acentuado.
"""

# ╔═╡ c53871d4-c739-4dcf-ad6d-c5dced86c208


# ╔═╡ 83d8e64c-e9ab-4065-a056-f189e30e149c
md"""
# 5 - Conclusões
"""

# ╔═╡ 5ab45915-9446-4583-a7b0-2ff97a5808f4
md"""
## 5.1 - Considerações finais
"""

# ╔═╡ 0ec4b965-80c4-4b40-925a-f3dcb2fd0115
md"""
No ensaio *back-to-back* verifica-se que o mesmo consome pouca potência elétrica da rede CC, comparativamente com a potência nominal das máquinas ensaiadas.\
Após o arranque do motor CC e ajuste à velocidade nominal, este alimenta mecanicamente o gerador CC. Após ligar o gerador CC em paralelo com a rede CC (verificadas as condições para essa manobra), o gerador alimentará eletricamente o motor CC.\
Por conseguinte, a potência consumida da rede elétrica corresponde ao somatório das perdas do grupo motor-gerador.  Este fato é muito importante e permite concluir que o ensaio *back-to-back* pode possibilitar o ensaio em carga de máquinas elétricas de elevada potência, comparativamente com a potência disponível da rede CC para a realização do ensaio, desde que a mesma suporte o arranque reostático do motor CC.
"""

# ╔═╡ e7aae6a9-1fa7-48a1-9b11-8e60c69cf9c9
md"""
O funcionamento do ensaio *back-to-back* utiliza a regulação dos circuitos de excitação de ambas as máquinas CC. Por um lado, o reóstato de campo do gerador CC ajusta a potência de saída do gerador (pois encontra-se ligado a uma rede CC de tensão constante), que por sua vez solicita mais potência mecânica ao motor CC (alimentado da mesma rede CC). Neste ajuste a velocidade poderá sofrer alguma variação significativa, sendo corrigida por atuação do reóstato de campo do motor CC.

Estas variações nos reostato de campo e consequentes variações nas correntes de excitação das máquinas provocam pequenas variações nas perdas constantes, contudo aceitáveis.
"""

# ╔═╡ 5dded0ab-c093-4e14-a2f2-de5d3506d171
md"""
Como conclusão final, o ensaio *back-to-back* permite a análise de potências, cálculo das perdas e rendimento de 2 máquinas elétricas em simultâneo e com baixo consumo de energia.
"""

# ╔═╡ 0b42e250-90d9-4b97-8fb6-0a7a896b92e5


# ╔═╡ e4d17d82-b7f0-4070-9177-e6a1cebb4c24
md"""
## 5.2 - Perspetivas de desenvolvimento futuro
"""

# ╔═╡ 7787b512-37e0-4c2e-8d43-88433ce6c764
md"""
O ensaio *back-to-back* pode ser também aproveitado para se analisar a reversibilidade de funcionamento das máquinas do grupo motor-gerador.

Assim, com o sistema em funcionamento, o aumento do reóstato de campo do circuito de excitação do gerador pode fazer baixar a sua força-eletromotriz, tal que esta seja menor que a tensão da rede CC, invertendo o sentido da corrente de linha nesta máquina, passando a regime motor:

$R_c 	\nearrow \quad \Rightarrow \quad I_{ex} \searrow\quad \Rightarrow \quad \phi \searrow \quad \Rightarrow \quad E \searrow$

$\text{Se:} \quad E<U \quad \Rightarrow \quad I_l < 0 \quad \text{, então:} \quad \rm gerador \triangleright motor$
"""

# ╔═╡ 4cbd2235-074d-4374-99c8-f290215b1640
md"""
Do lado do motor CC estabelece-se um raciocínio semelhante, para que este passe para o regime de funcionamento gerador:

$R_c 	\searrow \quad \Rightarrow \quad I_{ex} \nearrow\quad \Rightarrow \quad \phi \nearrow \quad \Rightarrow \quad E \nearrow$

$\text{Se:} \quad E>U \quad \Rightarrow \quad I_l > 0 \quad \text{, então:} \quad \rm motor \triangleright gerador$

"""

# ╔═╡ 46a23d85-70f0-4f15-9a76-8a3701a82183
md"""
O teste de reversibilidade com o grupo motor-gerador deve ser realizado com especial cuidado por causa do reostato de campo com o terminal $\textbf q$ (reostato de campo do gerador CC) estar em funcionamento. Assim, quando a máquina CC muda o regime de funcionamento de gerador para motor, tendo em conta a possibilidade do circuito de excitação ficar acidentalmente em aberto, e consequentemente, provocar o embalamento do motor CC.
"""

# ╔═╡ 8495592a-9619-4e2c-97fb-ef9f55f29f4d
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

# ╔═╡ 7ec2f5b9-5779-4f95-979d-96e23e742d5a
md"""
# *Notebook*
"""

# ╔═╡ 6bd294df-005b-4979-b2ee-39922b9223b7
md"""
Documentação das bibliotecas Julia utilizadas: \
[Plots](http://docs.juliaplots.org/latest/), [EasyFit](https://github.com/m3g/EasyFit.jl), [PrettyTables](https://ronisbr.github.io/PrettyTables.jl/stable/), [Statistics](https://docs.julialang.org/en/v1/stdlib/Statistics/), [BasicInterpolators](https://markmbaum.github.io/BasicInterpolators.jl/dev/), [SankeyPlots](https://github.com/daschw/SankeyPlots.jl), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html).
"""

# ╔═╡ 42b2d4f0-4d76-4e42-bd2a-f2ed48a4e4a4
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ aa0f3953-c4e8-4735-831c-9129e893ca05
TableOfContents(title="Índice")

# ╔═╡ 75189e15-e7bd-4dcc-9d41-27f83687b966
aside((md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""), v_offset=-100)

# ╔═╡ 61d8b963-5ad7-4f64-8b5f-46e3b40346a0
md"""
|  |  |
|:--:|:--|
|  | This notebook, [back2backlab.jl](https://ricardo-luis.github.io/me-2/back2backlab.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2026 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BasicInterpolators = "26cce99e-4866-4b6d-ab74-862489e035e0"
EasyFit = "fde71243-0cda-4261-b7c7-4845bd106b21"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PrettyTables = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
SankeyPlots = "8fd88ec8-d95c-41fc-b299-05f2225f2cc5"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
BasicInterpolators = "~0.7.1"
EasyFit = "~0.6.12"
Plots = "~1.41.7"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.83"
PrettyTables = "~3.4.8"
SankeyPlots = "~0.3.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.0"
manifest_format = "2.1"
project_hash = "011f8a8964978176c73103289ff761a867ae11ae"

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
weakdeps = ["SparseArrays", "StaticArrays"]

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
registries = "General"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "d57bd3762d308bded22c3b82d033bff85f6195c6"
registries = "General"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.4.0"

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

[[deps.BasicInterpolators]]
deps = ["LinearAlgebra", "Memoize", "Random"]
git-tree-sha1 = "3f7be532673fc4a22825e7884e9e0e876236b12a"
registries = "General"
uuid = "26cce99e-4866-4b6d-ab74-862489e035e0"
version = "0.7.1"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
registries = "General"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
registries = "General"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1fa950ebc3e37eccd51c6a8fe1f92f7d86263522"
registries = "General"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.7+0"

[[deps.ChunkCodecCore]]
git-tree-sha1 = "3496e2b359c27793d12bec54ec94be7983a6ceb2"
registries = "General"
uuid = "0b6fb165-00bc-4d37-ab8b-79f91016dbe1"
version = "1.0.2"

[[deps.ChunkCodecLibZlib]]
deps = ["ChunkCodecCore", "Zlib_jll"]
git-tree-sha1 = "d4101e848e8d3f585d61d244c2fe0c80a70e6b3b"
registries = "General"
uuid = "4c0bbee4-addc-4d73-81a0-b6caacae83c8"
version = "1.1.0"

[[deps.ChunkCodecLibZstd]]
deps = ["ChunkCodecCore", "Zstd_jll"]
git-tree-sha1 = "34d9873079e4cb3d0c62926a225136824677073f"
registries = "General"
uuid = "55437552-ac27-4d47-9aa3-63184e8fd398"
version = "1.0.0"

[[deps.CodecBzip2]]
deps = ["Bzip2_jll", "TranscodingStreams"]
git-tree-sha1 = "84990fa864b7f2b4901901ca12736e45ee79068c"
registries = "General"
uuid = "523fee87-0ab8-5b00-afb7-3ecf72e48cfd"
version = "0.8.5"

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

[[deps.ECOS]]
deps = ["CEnum", "ECOS_jll", "MathOptInterface"]
git-tree-sha1 = "ee59bee24d48b45327ea711b6182178018a8401a"
registries = "General"
uuid = "e2685f51-7e38-5353-a97d-a921fd2c8199"
version = "1.1.3"

[[deps.ECOS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "5f84034ddd642cf595e57d46ea2f085321c260e4"
registries = "General"
uuid = "c2c64177-6a8e-5dca-99a7-64895ad7445f"
version = "200.0.800+0"

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

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "6621fef488e496356c9c9625d0562c12a6070819"
registries = "General"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.20.0"

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

    [deps.FileIO.weakdeps]
    HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "5bad39456d9f0166184fce2248783dd9862645c1"
registries = "General"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.17.0"
weakdeps = ["PDMats", "SparseArrays", "StaticArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStaticArraysExt = "StaticArrays"
    FillArraysStatisticsExt = "Statistics"

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
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

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

[[deps.Graphs]]
deps = ["ArnoldiMethod", "DataStructures", "Inflate", "LinearAlgebra", "Random", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "dbb2b976f605b220dfe139d6db9f3859680da09e"
registries = "General"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.15.0"

    [deps.Graphs.extensions]
    GraphsSharedArraysExt = "SharedArrays"

    [deps.Graphs.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"
    SharedArrays = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "9d9531a9cb63a9edc33836414e82a07e81710de2"
registries = "General"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "100.14004.0+0"

[[deps.HashArrayMappedTries]]
git-tree-sha1 = "2eaa69a7cab70a52b9687c8bf950a5a93ec895ae"
registries = "General"
uuid = "076d061b-32b6-4027-95e0-9a2c6f6d7e74"
version = "0.2.0"

[[deps.HiGHS]]
deps = ["HiGHS_jll", "LinearAlgebra", "MathOptIIS", "MathOptInterface", "OpenBLAS32_jll", "PrecompileTools", "SparseArrays"]
git-tree-sha1 = "9efeab5bba4fa60bc22de16a116efd730d1c7a17"
registries = "General"
uuid = "87dc4568-4c63-4d18-b0c0-bb2238e4078b"
version = "1.25.2"

[[deps.HiGHS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Zlib_jll", "libblastrampoline_jll"]
git-tree-sha1 = "d4e63f395d10590fcece8d35005dd7b9a4862635"
registries = "General"
uuid = "8fd58aa0-07eb-5a78-9b36-339c94fd15ea"
version = "1.15.1+3"

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

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
registries = "General"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

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

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
registries = "General"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
registries = "General"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
registries = "General"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["ChunkCodecLibZlib", "ChunkCodecLibZstd", "FileIO", "MacroTools", "Mmap", "OrderedCollections", "PrecompileTools", "ScopedValues"]
git-tree-sha1 = "877edc1d2f51adcef0bfacd19464a19e7cfddddb"
registries = "General"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.6.6"
weakdeps = ["UnPack"]

    [deps.JLD2.extensions]
    UnPackExt = "UnPack"

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
git-tree-sha1 = "88352712893ec50bee3680605891eaf0e9ed6368"
registries = "General"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "1.8.0"

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

[[deps.JuMP]]
deps = ["LinearAlgebra", "MacroTools", "MathOptInterface", "MutableArithmetics", "OrderedCollections", "PrecompileTools", "Printf", "SparseArrays"]
git-tree-sha1 = "4f27b21df3b47e8c08a83ead049afb621b2f5b3c"
registries = "General"
uuid = "4076af6c-e467-56ae-b986-b466b2749572"
version = "1.31.2"

    [deps.JuMP.extensions]
    JuMPDimensionalDataExt = "DimensionalData"

    [deps.JuMP.weakdeps]
    DimensionalData = "0703355e-b756-11e9-17c0-8b28908087d0"

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

[[deps.LayeredLayouts]]
deps = ["Dates", "ECOS", "Graphs", "HiGHS", "IterTools", "JuMP", "Random"]
git-tree-sha1 = "9005411360f1693723a8ad1862fbbcfb99449c4b"
registries = "General"
uuid = "f4a74d36-062a-4d48-97cd-1356bad1de4e"
version = "0.2.11"

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

[[deps.MathOptIIS]]
deps = ["MathOptInterface"]
git-tree-sha1 = "3b3d69130d8ab8c39d5fa4d30e20a8e6428c9d37"
registries = "General"
uuid = "8c4f8055-bd93-4160-a86b-a0c04941dbff"
version = "0.2.0"

[[deps.MathOptInterface]]
deps = ["CodecBzip2", "CodecZlib", "ForwardDiff", "JSON", "LinearAlgebra", "MutableArithmetics", "NaNMath", "OrderedCollections", "PrecompileTools", "Printf", "SparseArrays", "SpecialFunctions", "Test"]
git-tree-sha1 = "d10ba577e0b5a0481fab01dfd31fb20af3326954"
registries = "General"
uuid = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
version = "1.53.0"

    [deps.MathOptInterface.extensions]
    MathOptInterfaceBenchmarkToolsExt = "BenchmarkTools"
    MathOptInterfaceCliqueTreesExt = "CliqueTrees"

    [deps.MathOptInterface.weakdeps]
    BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
    CliqueTrees = "60701a23-6482-424a-84db-faee86b9b1f8"

[[deps.Measures]]
git-tree-sha1 = "b513cedd20d9c914783d8ad83d08120702bf2c77"
registries = "General"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.3"

[[deps.Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
registries = "General"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "3a8f462a180a9d735e340f4e8d5f364d411da3a4"
registries = "General"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.8.1"

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

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "dc5b2c4c111c46bc79ac4405eeb563523b39c004"
registries = "General"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.8.0"

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

[[deps.OpenBLAS32_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "libblastrampoline_jll"]
git-tree-sha1 = "30870d0f2dc0b2dba76b10df1c58c7f018413e56"
registries = "General"
uuid = "656ef2d0-ae68-5445-9ca0-591084a874a2"
version = "0.3.34+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.30+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

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
deps = ["Dates", "PrecompileTools"]
git-tree-sha1 = "663e8b48b789916221e0765393b289ca6c88f24e"
registries = "General"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "3.0.0"

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
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "REPL", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1b8aa19f229b1cea7fc93874a52e49db6a854450"
registries = "General"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "3.4.8"

    [deps.PrettyTables.extensions]
    PrettyTablesExcelExt = "XLSX"
    PrettyTablesTypstryExt = "Typstry"

    [deps.PrettyTables.weakdeps]
    Typstry = "f0ed7684-a786-439e-b1e3-3b82803b501e"
    XLSX = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"

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

[[deps.SankeyPlots]]
deps = ["Graphs", "LayeredLayouts", "MetaGraphs", "Plots", "SparseArrays"]
git-tree-sha1 = "72e2a908c9aa12ef3f7e09354c506cd4b323e9f7"
registries = "General"
uuid = "8fd88ec8-d95c-41fc-b299-05f2225f2cc5"
version = "0.3.0"

[[deps.ScopedValues]]
deps = ["HashArrayMappedTries", "Logging"]
git-tree-sha1 = "67a144433c4ce877ee6d1ada69a124d6b1ecf7be"
registries = "General"
uuid = "7e506255-f358-4e82-b7e4-beb19740aa63"
version = "1.6.2"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
registries = "General"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

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

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "7ddb0b49c109481b046972c0e4ab02b2127d6a75"
registries = "General"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.6"

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

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "e206cf4850fd7ac4255ffd2b98922f563e18ac53"
registries = "General"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.20"

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

    [deps.StaticArrays.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

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
git-tree-sha1 = "773065c6e0e903924a9d838259be74338422aef2"
registries = "General"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.5.0"

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
git-tree-sha1 = "a6dd904babc04670c784f81b67957a3545271610"
registries = "General"
uuid = "1c621080-faea-4a02-84b6-bbd5e436b8fe"
version = "1.1.0"

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
git-tree-sha1 = "1f0f9f401753701a7e4113b5056ca38d33875b55"
registries = "General"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.29.0"
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
# ╟─1aceb22f-57fe-4428-bbd7-3410a10e269e
# ╟─c064e55c-6924-49b7-abbc-385a081c57b2
# ╟─01d6ccf1-a046-4386-95b9-7a8437e6bc48
# ╟─aa438d59-98d7-41b6-b34d-aa55220cf04f
# ╟─57972b14-d0eb-49f2-a8fe-fbfa25eb2f43
# ╟─dcfb10ac-3a34-477f-ae1e-6a4b42fdc0d2
# ╟─5d618284-7f40-4d33-94a1-829407bd5f47
# ╟─07eeed4a-6a40-4585-b04f-26da0157fe2e
# ╟─1eb4379f-2d29-4dea-b6c5-cd2f81ed8381
# ╟─184d5409-76fa-4970-9da7-6d8c8bd79713
# ╟─f8de4a5c-64a2-49c4-88e2-c26c843b1fc1
# ╟─39721ee5-b4f8-47ed-ae4f-0865952ebd28
# ╟─3010fa73-fdb8-4ad9-94dc-45db49ae7fcf
# ╟─f60d6cdd-7ff4-4a00-b2aa-a1440234ec6d
# ╟─5f0b7230-28eb-4394-981f-0974e49284a3
# ╟─127a7dbf-88fe-4b28-a265-7bf315850497
# ╟─c387e50c-5aac-4901-b1f3-51b690c38a56
# ╟─dfa54345-bcae-4350-aa43-72cd62b83d65
# ╟─59b3486d-61cd-43ac-ae1c-4bd04ab5dd40
# ╟─eb5f4190-17a0-4bac-b2a2-1d35622f3d2c
# ╟─fce78f7b-dcdc-4ae3-918d-622db2f27269
# ╟─6fef9e1c-e321-4ef8-9140-dc4dbfe49936
# ╟─349d542f-024d-4982-867c-afa9e105db27
# ╟─f1b48849-a61f-4825-bcc8-ff12d3c09987
# ╟─e05493c5-1231-4fda-821c-65420c221551
# ╠═5bb9b54a-56f3-431c-b47c-75a58bff7d22
# ╟─494278aa-f24d-4168-8615-f7803495fafd
# ╠═080ba59a-6a4a-424e-8741-9b59332c2f86
# ╟─60cc12ac-6fe6-439b-a149-39ffa704ba8b
# ╠═a41a8eeb-c2bf-4025-8a91-a5654ba69ca7
# ╟─d37297d1-3e7d-4a17-9169-6d9fe268f2c5
# ╟─df5bc5cc-9d9d-41d7-9956-a5f9af31c4cf
# ╟─13d6e0d9-2cb9-4125-a406-c4caa0d63719
# ╟─cf35b99b-b280-4866-a0e2-0092167a55ba
# ╠═fdb1a1d4-fb0f-45ae-96ef-5c3b5bec7f69
# ╠═f202a1bf-aaf8-4115-98e9-eba0da1666e4
# ╠═bba03ae4-313e-4e3a-a367-73b1d28e733e
# ╠═22e2b92e-d1e2-4f4b-b61c-f4776976f216
# ╟─b1092f90-3d0b-4f5c-8d55-79a5a199b49f
# ╟─b74e6eae-d059-4409-b0cb-ba19475a53a0
# ╟─7becf999-5f11-4a47-8e3f-2b775f52bd27
# ╟─b32d55d7-80b2-45f1-abaf-ef8f6958e980
# ╠═f0132080-ad3c-47d1-b0e3-c9c7994c072f
# ╟─71a60d6f-1527-4537-952d-b490af18a935
# ╟─6a7b7432-cb54-445a-aa39-33a13fb958ba
# ╠═5bcefcd9-f30e-4b40-a1f0-b66ff862d963
# ╟─81298eb8-b548-42aa-9fea-fa502482578b
# ╟─1931180b-424d-43ba-af25-61e84faf0eaf
# ╟─7e48b1e0-b66c-4773-9189-b72e931b8520
# ╟─df08b5c7-d63b-430d-8869-a994ed85b73c
# ╟─3a44a05d-68a4-4622-afd3-1b67e95c7088
# ╟─bc95d83c-fb07-4f24-b08a-b461d871c79e
# ╟─404e5b4b-0ddc-45b0-a4af-e29618a501be
# ╟─2f7931fa-262f-4f76-8f4b-f28e26989a2b
# ╟─66ada8ac-6556-4d18-9cf3-cbdbf3f9bc69
# ╟─01e08f32-9f91-41f9-b022-ad877864a784
# ╟─d12d08d6-4c4c-4afc-b4e5-970f86a440e5
# ╠═2b7754b3-44b3-4a09-99e2-4827afbacc64
# ╠═d777bcfb-ffad-4061-b86b-cf3f2709576d
# ╟─9c117644-13d3-4de3-a30b-e626df7d6815
# ╠═fc62b652-0d92-49e4-ae27-fd04a6b1d8bd
# ╟─dff17723-bba8-491f-af37-9119e4ff4445
# ╠═1c048c68-2a41-4710-9d5d-e092abbfc7d9
# ╟─55483f43-ca65-4775-a4b7-b824295ad34d
# ╠═4cda0d79-6a76-4529-b70e-4eb0bf9c2451
# ╟─4643e926-67e5-4ac5-a332-1895b992b981
# ╠═0865009d-6d80-452b-b9e5-74b424f9b3c3
# ╟─361b5bbe-2fcd-4f96-8488-c52d9b2dbea5
# ╠═863fe345-3a98-46d6-9112-78ee18635ffe
# ╟─bf4807d5-6fbb-43bc-9be3-475b2ad6e0f6
# ╟─f7e7769e-9be0-41bb-900b-9034db833a5b
# ╠═ad8fdc0f-4059-4bec-98a5-8b38b5a17fd0
# ╟─7c45e9f8-de6b-4bf8-aa91-5b23a47f5d02
# ╠═5d25244c-7d05-43af-a6a5-69fdb52a253e
# ╟─29c9a3a5-73a1-4daa-b492-178b97917258
# ╠═901eaef2-2cff-4131-b19c-b43a88b35b34
# ╟─99f6a01a-4a46-43dd-8ef9-a614302e29af
# ╟─076bd182-885d-4808-ba4a-9d125cd09957
# ╟─c4fd1d3b-9b18-48b3-a0fd-466fcb3e17ee
# ╠═d780fb54-2677-481e-a228-478845fba613
# ╟─d65460a3-a703-44f6-aa42-a3dd47ae3034
# ╠═7bcd562e-970f-4614-94d0-41b8f47a5ff2
# ╟─18159d33-d61e-44cc-9966-801f15b7f5d5
# ╠═51f8e7ee-868e-47d9-bfa5-4ac06f37d942
# ╟─95fdbbc4-b612-4512-9069-6110e41f9e9d
# ╟─c771cef0-8fb8-4414-af8a-3e6512832d90
# ╟─46273cec-629b-4a2f-ba2c-e354e5003adc
# ╟─50f9ef55-ec4d-4801-a7df-b755fcc9cdef
# ╟─80d0dbc9-9e4c-4270-9395-baec8974bdf2
# ╟─fbb2ce7b-3a81-4c4e-b271-0f33819837a7
# ╟─994319d8-2e54-4edd-a6fb-cd8df9f9fcd7
# ╠═a11a242c-4672-4639-ad54-faa63d0a1cd1
# ╠═6873136d-76b9-41ee-a61f-2dd473ac8aca
# ╠═b6d6d602-03f6-4d11-be10-631a3502ea40
# ╠═f5d3be1c-ccb1-43ec-8d5b-5afc631cb54b
# ╠═e8e790c5-fd10-4797-8dbf-74cde9ac20a2
# ╟─469dd7f7-dc57-4743-a844-714fa3952c8c
# ╟─bbdfee6a-fd4d-4220-aadf-9ceba2415a75
# ╟─884beeaf-d196-4d9a-9088-a3b88ff5670e
# ╠═69892e4e-821b-4efa-b7f5-26bdbb5d0f8a
# ╟─1658f96c-7d15-4ed2-9f58-a161bc8b635f
# ╠═3ad1607a-66c4-42e2-a088-db1832fd1f32
# ╟─49e3234a-c066-42bc-bc90-bf7699309286
# ╟─065d2711-a5b6-4fcd-8e99-919296af78cb
# ╠═73632b98-0c48-41cd-a897-162363d8d3b9
# ╟─debd87f9-13ee-4177-8245-c9cc4df1d157
# ╟─2a0e3a6a-0fd0-4f9e-ab54-2377d0761ba3
# ╟─26f2ef0d-bb46-4619-8ffe-98f3ac026269
# ╟─e9e3afa0-0b4d-4367-a7f9-acd8992a88a5
# ╟─1ee60c29-bb29-4d9c-a2d9-20fac192f89f
# ╟─b4cf06cd-3872-4380-be18-7c90ae7f8b84
# ╟─6c2bab0b-4785-413b-a851-0c0ab06c73a4
# ╟─1e3c4060-5d78-4159-bb2d-caf158d9a32d
# ╠═830796ba-f8d6-4843-9297-e76492589d49
# ╟─5ea61cf4-4f87-43ef-8556-f37ea60d2515
# ╟─c870e56a-cc10-4f85-9767-af46d9845b6a
# ╟─d9063387-a1d9-44e5-81e8-9dd4111ad72a
# ╠═0a699f92-004d-4a44-aae6-7fc0e9aad041
# ╟─36ce1f19-59f6-4595-a75a-22f519e326d9
# ╟─c674d531-be5a-45b6-b5be-480753f0135f
# ╟─e40a1b59-ed60-4081-afbf-661373b8b3fa
# ╟─28563a65-dfbd-4143-a0ec-772e553a3fb9
# ╠═97a33323-b7ae-4aa7-b2c1-a8f302694f62
# ╟─291e034f-a119-4c9b-8a50-4a35cd54e055
# ╟─c53871d4-c739-4dcf-ad6d-c5dced86c208
# ╟─83d8e64c-e9ab-4065-a056-f189e30e149c
# ╟─5ab45915-9446-4583-a7b0-2ff97a5808f4
# ╟─0ec4b965-80c4-4b40-925a-f3dcb2fd0115
# ╟─e7aae6a9-1fa7-48a1-9b11-8e60c69cf9c9
# ╟─5dded0ab-c093-4e14-a2f2-de5d3506d171
# ╟─0b42e250-90d9-4b97-8fb6-0a7a896b92e5
# ╟─e4d17d82-b7f0-4070-9177-e6a1cebb4c24
# ╟─7787b512-37e0-4c2e-8d43-88433ce6c764
# ╟─4cbd2235-074d-4374-99c8-f290215b1640
# ╟─46a23d85-70f0-4f15-9a76-8a3701a82183
# ╟─8495592a-9619-4e2c-97fb-ef9f55f29f4d
# ╟─7ec2f5b9-5779-4f95-979d-96e23e742d5a
# ╟─6bd294df-005b-4979-b2ee-39922b9223b7
# ╠═e89303b7-3dbb-452c-bd71-ddaac5d22dc4
# ╟─42b2d4f0-4d76-4e42-bd2a-f2ed48a4e4a4
# ╠═aa0f3953-c4e8-4735-831c-9129e893ca05
# ╟─75189e15-e7bd-4dcc-9d41-27f83687b966
# ╟─61d8b963-5ad7-4f64-8b5f-46e3b40346a0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
