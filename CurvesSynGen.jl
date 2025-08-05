### A Pluto.jl notebook ###
# v0.20.13

#> [frontmatter]
#> chapter = 2
#> section = 2
#> order = 2
#> image = "https://github.com/Ricardo-Luis/me-2/blob/681c6a43493d6a00226494f752c8c6d2708da9f1/images/card/CurvesSynGen.png?raw=true"
#> title = "Alternador, curvas características"
#> layout = "layout.jlhtml"
#> tags = ["lecture", "module3"]
#> date = "2024-10-29"
#> description = "Este exercício que analisa o funcionamento de um alternador síncrono 3~, com base nos seus dados nominais e característica magnética. Inclui a determinação da corrente de excitação necessária em vazio e em carga, o cálculo da FEM gerada, do binário de acionamento e a construção do diagrama P-Q. São ainda traçadas as características externas da máquina para diferentes fatores de potência (indutivo, capacitivo e unitário), em diferentes condições de funcionamento, permitindo compreender o comportamento do alternador"
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io/"

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

# ╔═╡ 46957491-f987-44b2-aa8c-a4215fd534ec
using PlutoUI, PlutoTeachingTools, Plots, Dierckx 						
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - Dierckx.jl, tool for data interpolation
=# 

# ╔═╡ 04954281-6692-4c19-86a5-1f45a2107cc3
TwoColumnWideLeft(md"`CurvesSynGen.jl`", md"`Last update: 29·10·2024`")

# ╔═╡ b4536854-efd9-4ee4-957c-9743ec32aa65
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS SÍNCRONAS TRIFÁSICAS}$

$\text{EXERCÍCIO 2}$ 

$\textbf{Alternador síncrono de polos lisos}$

$\textbf{Curvas características}$
---
"""

# ╔═╡ 2911bd1b-2a50-412f-982c-30eb2b550e38
md"""
# Exercício 2. Dados:
"""

# ╔═╡ a9743237-6408-406b-a8eb-9cbf8867f9ef
md"""
**Um gerador síncrono, ligação Y, 2300V, 1000kVA, fator de potência 0,8 indutivo,
60Hz, 2 pólos, tem uma reatância síncrona de 1,1Ω e uma resistência do induzido de 0,15Ω. A 60Hz, as perdas por atrito e ventilação são 24kW, e as perdas no ferro 18kW. O enrolamento de campo é alimentado por uma tensão contínua de 200V e o valor máximo de $$I_F$$ são 10A. O ensaio em circuito aberto deste gerador é o apresentado na figura seguinte:**
"""

# ╔═╡ 4e44ac99-e751-49f0-a228-c8c34a2861f2
begin
	Iₑₓ = [0, 0.24, 0.58, 0.93, 1.12, 1.39, 1.67, 1.94, 2.18, 2.55, 2.80, 3.04, 3.29, 3.57, 3.78, 3.97, 4.25, 4.54, 4.94, 5.25, 5.68, 6.13, 6.62, 7.03, 7.55, 8.00, 8.43, 8.92, 9.47, 10.0]
	
	fem = [20.2, 176.8, 382.8, 626.8, 756.0, 914.0, 1086.2, 1244.0, 1378.0, 1570.0, 1698.6, 1812.8, 1928.2, 2038.2, 2128.8, 2200.8, 2292.0, 2392.4, 2498.0, 2560.0, 2636.4, 2694.0, 2746.4, 2784.8, 2818.2, 2846.8, 2870.8, 2894.8, 2914.0, 2928.2]

	plot(Iₑₓ, fem,
			minorticks=5, title="E₀=f(Iₑₓ)", 
			xlabel = "Iₑₓ (A)", ylabel="Eₒ (V)", label=:none)
end

# ╔═╡ 42931953-b637-42f5-b451-ab374a89ea70
(Sₙ, Uₙ, cosφₙ, f, p, Xₛ, Rₛ, pᵣₒₜ, p_ferro) = (1000e3, 2300, 0.8, 60, 1, 1.1, 0.15, 24e3, 18e3)

# ╔═╡ ab85c3a5-f0b1-4d66-b162-4561a02e82b5


# ╔═╡ cb5bcb47-51c3-4a3c-bdbc-581e37f82e80
md"""
(**Fonte:** adaptado do problema 5.2 de [^Chapman2005])
"""

# ╔═╡ d18c19c9-2bd8-4e68-8b0c-bcf9a7fadfe2


# ╔═╡ b2cfb3de-c46b-40c5-b982-da47b62a0628
md"""
# a) $$I_{exc}$$, alternador em vazio 💻
**Qual o valor da corrente de campo necessário para que a tensão composta do seja de
2300V, quando o alternador funciona em vazio?**
"""

# ╔═╡ c88ac310-ece1-4738-b936-0fcfde134810
md"""
A corrente de excitação define o valor da tensão de vazio no funcionamento do alternador, ou seja, $$U_0=E_0$$. Assim, assumindo que a característica magnética, $$E_0=f(I_{ex})$$, foi obtida para a velocidade síncrona da máquina, o valor da corrente de campo, $$I_{ex}$$, obtém-se por leitura de $$E_0=f(I_{ex})$$ para a tensão de $$2300$$V: 
"""

# ╔═╡ 38fa3ee4-4435-40b9-a47a-ce8292535d75
md"""
 $$I_{ex} (\rm A):$$ $(@bind Iexc PlutoUI.Slider(0:0.01:10, default=0,show_value=true))
"""

# ╔═╡ c64c2444-bb8b-4c52-960e-4c41445a98ca
# ABy reading the graph, E₀=f(Iₑₓ)
begin
	plot(Iₑₓ, fem,
		title="E₀=f(Iₑₓ)", xlabel = "Iₑₓ (A)", ylabel="Eₒ (V)", 
		label=:none, minorticks=10, linewidth=2)
		
	# move the vertical line until it crosses 2300V at E₀=f(Iₑₓ): plot!([<->], ...)
	plot!([2300], seriestype=:hline, linestyle=:dash, label=:none)
	plot!([Iexc], seriestype=:vline, linestyle=:dash, label=:none)
end

# ╔═╡ 825f12d2-9153-4ee1-9d83-640f49d88d6d
begin
	# computational method of querying the E₀(Iₑₓ) curve, by interpolating the data using Pkg Dierckx.jl:
	i_E₀ = Spline1D(fem, Iₑₓ)	
	Iₑₓ_2300 = i_E₀(2300)
	Iₑₓ_2300 = round(Iₑₓ_2300, digits=2)
end;

# ╔═╡ 24ae7ecd-9423-4edf-bf88-6e71f0e27d82
md"""
Em alternativa à leitura do gráfico de $$E_0=f(I_{ex})$$, pode-se consultar os dados de $$E_0$$ e $$I_{ex}$$ e obter a corrente de campo por interpolação linear. Assim, tém-se:

$$E_0=2300\mathrm{V}\:\in\:[(4.25\mathrm{A}, 2292.0\mathrm{V}),(4.44\mathrm{A}, 2392.4\mathrm{V})]$$

Por interpolação linear, obtém-se:

$$\frac{2392.4-2292.0}{4.44-4.25}=\frac{2392.4-2300.0}{4.44-I_{ex}}$$

 $$I_{ex}=$$ $(Iₑₓ_2300)A
"""

# ╔═╡ 93e6e95e-8d12-450d-9558-ef2780de56f8


# ╔═╡ 4da8eaa3-0c65-4351-9242-adfc95af7353
md"""
# b) $$E_0$$ nas condições nominais
**Qual a força eletromotriz (FEM) gerada por esta máquina nas condições nominais?**
"""

# ╔═╡ 4d2962a9-0816-4b25-ae7b-f3c87d375428
md"""
Considerando a equação vetorial da força eletromotriz, $$\overline{E}_0$$, por fase:

$$\overline{E}_0=\overline{U}+(R_s+jX_s)\overline{I}$$

Estando a máquina com as ligações em estrela: $$\quad U=\frac{U_n}{\sqrt3}\quad$$ e $$\quad I=I_n\quad$$ com $$\quad I_n=\frac{S_n}{\sqrt3U_n}$$

Assim, o vetor da FEM vem dado por:

$$\overline{E}_0=\frac{U_n}{\sqrt3}∠0°+(R_s+jX_s)(I_n∠\varphi)$$
"""

# ╔═╡ ab03c270-6924-4c14-9375-3ae600b39250


# ╔═╡ a30977b0-751f-437d-b185-55127263b6bc
md"""
### Diagrama vetorial de tensões
"""

# ╔═╡ c31adb10-b16b-45f3-9f06-ea5c68396dc8


# ╔═╡ f1abeadc-7d88-4cb3-8998-c4242460191e
md"""
# c) $$I_{exc}$$, alternador em carga 
**Qual o valor da corrente de campo necessário para obter a tensão nominal, quando o alternador se encontra nas condições nominais?**
"""

# ╔═╡ 02deedfc-2306-470b-9a16-63b45a5ae638
md"""
Atendendo que os elementos de estudo da máquina síncrona: circuito equivalente, diagrama e equação vetoriais, são representações por fase do seu funcionamento em regime permanente, é necessário ter em conta que a FEM entre fases, $$E_{0ff}$$, vem dada por:

$$E_{0ff}=E_0\sqrt3$$
"""

# ╔═╡ b81dee37-67b6-4904-a0ce-1f6bdb48de2d


# ╔═╡ 3d61fd46-c01c-4c9a-ad5a-6182e8adef45
md"""
# d) Potência e binário de acionamento
**Quais os valores de potência e binário necessários, para o acionamento deste alternador nas condições nominais?**
"""

# ╔═╡ 593c3b9a-76be-4fe3-8f9d-baaf86035b8c
md"""
Considerando o balanço de potências da máquina síncrona em regime alternador, a potência mecânica recebida é dada por:

$$P_{ab}^{mec}=P_u+p_J^{est}+p_{rot}+ p_{Fe}$$

onde, $$\quad P_u=S_n\cos\varphi_n\quad$$ e $$\quad p_J^{est}=3R_sI_n^2$$ 

Assim, o binário de acionamento vem dado por:

$$T_{mec}=\frac{P_{ab}^{mec}}{\omega_{mec}}$$

em que, $$\quad \omega_{mec}=\frac{2\pi f}{p}\quad$$ com $$\quad p\quad$$ sendo o número de pares de pólos da máquina. 
"""

# ╔═╡ 4d673ff6-e368-4c26-88dd-bc105a96e7c6
md"""
Note-se que neste balanço de potências não é considerada a potência no circuito de excitação para o cálculo do binário de acionamento. Sendo um circuito de excitação separada, as suas perdas não intervêm no processo de conversão de energia da máquina. 

Assim, a potência absorvida pelo circuito de excitação, $$P_{ab}^{exc}=U_{ex}I_{ex}$$, é totalmente dispendida em perdas por efeito de Joule, $$p_J^{exc}=R_FI_{ex}$$, por conseguinte, $$P_{ab}^{exc}=p_J^{exc}$$, entrando na determinação do rendimento da máquina síncrona, $$\eta$$, em que todas as perdas envolvidas são consideradas:

$$\eta=\frac{P_u}{P_{ab}^{mec}+p_J^{exc}}$$
"""

# ╔═╡ 4c577232-2e70-4b9f-9ab6-c24b66824b81


# ╔═╡ 5de1389d-a54c-48f0-9c93-4cf46c4c5a4a
md"""
# e) Diagrama P-Q
**Obtenha o diagrama P-Q deste alternador;**
"""

# ╔═╡ 840f2ac8-2282-4cc7-8422-f7e1c078c7e9
md"""
Para a determinação do diagrama $$P$$\-$$Q$$, conhecidas também por *capability curves*, desprezam-se as perdas por efeito de Joule no estator, ou seja, $$R_s=0$$Ω.   

Assim, a partir do diagrama vetorial de tensões resultante, o afixo do vetor da tensão, $$\overline{U}$$, marca o início de um sistema de eixos: potência ativa (ordenada) e potência reativa(abcissa).

Os módulos dos vetores: $$\overline{U}$$, $$j X_s\overline{I}$$ e $$\overline{E}_0$$ são multiplicados por $$\frac{3U}{X_s}$$ para se obter uma leitura de potências $$(\mathrm{VAr}, \mathrm{W})$$. Com a máquina em regime nominal são traçados o lugar geométrico das novas grandezas, com as designações:
- limite térmico do estator (lugar geométrico de $$\overline{S}=3U\overline{I}$$);
- limite térmico do rotor (lugar geométrico de $$\frac{3U\overline{E}_0}{X_s}-\frac{3U^2}{X_s}$$);
- Adicionalmente coloca-se o limite mecânico do acionamento/turbina.

No caso de um alternador, a área de funcionamento possível, cumprindo diversos os limites (estator, rotor, turbina), fica delimitada pelas curvas estabelecidas no diagrama P-Q, nos 1º e 2º quadrantes $$(\delta\geqslant0)$$.

"""

# ╔═╡ ffdfe498-9c29-44a1-b31e-19f17b0ba3ab


# ╔═╡ 02f9cc22-91c5-4b01-90bc-3359008b6dc7
md"""
# f) Características externas, cruzando $$(I_n, U_n)$$
**Considerando as condições nominais, obtenha a característica externa, $$U=f(I)$$, para $$\cos\varphi=0.8(i)$$, $$\cos\varphi=0.8(c)$$ e $$\cos\varphi=1$$;**
"""

# ╔═╡ 7111bdc6-fab3-48be-89c1-3ce91de11c57
md"""
O funcionamento do alternador nas condições nominais $$(I_n, U_n)$$ para diferentes fatores de potência exige diferentes valores de força eletromotriz, que se obtém pela equação vetorial por fase de $$\overline{E}_0$$.  

A determinação da caracterísica externa procede-se como já analisado no exercício anterior.
"""

# ╔═╡ 2b5da421-a849-4d34-b7d8-1acade30ee21
md"""
Determinação da característica externa para $$\cos\varphi=0,8(i)$$:
"""

# ╔═╡ 58caf67b-b57d-47d2-b210-b86e662d117e
md"""
Determinação da característica externa para $$\cos\varphi=0,8(c)$$:
"""

# ╔═╡ ab07ed6e-e3da-469c-a4e9-dfd9524869ce
md"""
Determinação da característica externa para $$\cos\varphi=1$$:
"""

# ╔═╡ 52f522dd-7e25-4841-92b2-7b54ca1040cf


# ╔═╡ 19a1c85d-25af-4aeb-ad7b-2d19396bde89
md"""
# g) Características externas, partindo $$(I=0, U=U_0)$$
**Para uma FEM de 2500V determine as características externas, $$U=f(I)$$, para $$\cos\varphi=0.8(i)$$, $$\cos\varphi=0.8(c)$$ e $$\cos\varphi=1$$;**
"""

# ╔═╡ 9c27b79c-2c53-44f0-b5e1-5d62570c3ba4
md"""
Determinação da característica externa para $$\cos\varphi=0,8(i)$$:
"""

# ╔═╡ 5530ca56-7421-4521-abeb-566a8bdb9756
md"""
Determinação da característica externa para $$\cos\varphi=0,8(c)$$:
"""

# ╔═╡ c4698c03-47e3-4cb1-9817-a29618327303
md"""
Determinação da característica externa para $$\cos\varphi=1$$:
"""

# ╔═╡ 9be1b929-edba-41ca-b970-4efcf6ec63c7


# ╔═╡ 68888153-d958-42a9-abd7-463d0b42223b
md"""
# Bibliografia
"""

# ╔═╡ 1884eeff-905c-4ad0-a940-5822aacfd73b
md"""
[^Chapman2005]:  Chapman, S. J., Electric Machinery Fundamentals, 4ᵗʰ edition, McGraw-Hill, USA, 2005.
"""

# ╔═╡ 60ecdb18-d321-48e8-8622-e74960675b3f


# ╔═╡ 66d23e11-bab8-4282-a356-e27a97985a41
# to adjust the notebook margins and used font-family/size on text content
html"""<style>
@media screen {
	main {
		margin: auto;
		max-width: 1920px;
		padding-left: 5%;
		padding-right: 25.9%; 
		}
	}
pluto-output {
    font-family: system-ui;
	font-size:  100%
}
</style>
"""

# ╔═╡ b689e21d-ff9b-412f-b195-3a3fc56b434b
md"""
# *Notebook*
"""

# ╔═╡ 8390d93f-f542-4ac2-9b07-6aae685105af
md"""
## Notação complexa em `Julia` 
"""

# ╔═╡ 2abb9621-8af2-48fa-b6d9-72922f6166a9
md"""
Na linguagem `Julia` os números complexos são nativamente apresentados na forma retangular, sendo a unidade imaginária representada por `im`.\
No bloco seguinte definem-se o operador imaginário, `j`, e a função fasor, `∠(x)`, de modo a facilitar a escrita comummente utilizada em engenharia eletrotécnica quanto à representação de grandezas complexas, na forma retangular e polar, respectivamente. 
"""

# ╔═╡ 00ded203-b6a6-4c1d-a6c4-9b7c97eae79d
begin
	j = Base.im 				# to use the Julia imaginary unit, "im", as "j"
	∠(θ) = cis(deg2rad(θ))  	# to use phasors with angle in degrees. Note: to write the symbol "∠", do: \angle + [TAB] key
end;

# ╔═╡ e29ade22-1092-4a05-b078-d5d50509b875
begin
	# Iₙ, φₙ:
	Iₙ = Sₙ/(√3*Uₙ)
	Iₙ = round(Iₙ, digits=1)
	φₙ = -acos(cosφₙ)
	φₙ = rad2deg(φₙ)
	φₙ = round(φₙ, digits=2)
	
	# E₀ₙ:
	E⃗₀ₙ = (Uₙ/√3)∠(0)+(Rₛ+j*Xₛ)*((Iₙ)∠(φₙ))
	E₀ₙ = abs(E⃗₀ₙ)
	E₀ₙ = round(E₀ₙ, digits=1)
	
	# δ:
	δₙ = angle(E⃗₀ₙ)
	δₙ = rad2deg(δₙ)
	δₙ = round(δₙ, digits=1)
	
	# results: A, °, °, V 	
	Iₙ, φₙ, δₙ, E₀ₙ  
end

# ╔═╡ a7d1c835-2494-45ed-a8b2-a2cc89fb8636
# By reading the graph, E₀=f(Iₑₓ)
begin
	plot(Iₑₓ, fem,
		title="E₀=f(Iₑₓ)", xlabel = "Iₑₓ (A)", ylabel="Eₒ (V)",
		label=:none, minorticks=10, linewidth=2)
	plot!([E₀ₙ*√3], seriestype=:hline, linestyle=:dash, label=:none)
	
	# move the vertical line until it crosses 2300V at E₀=f(Iₑₓ): plot!([<->], ...)
	plot!([5.85], seriestype=:vline, linestyle=:dash, label=:none)
end

# ╔═╡ c653686d-f8d8-48c0-87dd-0b3c8027ce6a
begin
	# Linear interpolation of the E₀=f(Iₑₓ)
	Iₑₓ_Uₙ = i_E₀(E₀ₙ*√3)
	Iₑₓ_Uₙ = round(Iₑₓ_Uₙ, digits=2)
end

# ╔═╡ c08ae18e-7857-4dd0-b157-462ef9ab2c34
md"""
Assim, de modo similar ao realizado na alína a), obtém-se uma corrente de campo, $$I_{ex}=$$ $(Iₑₓ_Uₙ)A, por um dos processos anteriormente explicados:
"""

# ╔═╡ 4d172d04-2412-48cf-8136-ccce4fdb0c61
begin
	Pᵤ = Sₙ*cosφₙ
	Pⱼᵉˢᵗ = 3*Rₛ*Iₙ^2
	Pab = Pᵤ + Pⱼᵉˢᵗ + pᵣₒₜ + p_ferro
	ωmec = 2*π*f/p
	Tmec = Pab/ωmec
	Pab = round(Pab/1000, digits=2)
	Tmec = round(Tmec/1000, digits=2)
	Pab, Tmec
end

# ╔═╡ 3619a6e1-1015-46ef-9dcf-ddd44e0bdb63
md"""
Resulta assim, potência e binário mecânicos, $$P_{ab}^{mec}=$$ $(Pab) $$\rm kW\quad$$ e $$\quad T_{mec}=$$ $(Tmec) $$\rm kNm$$, respetivamente.
"""

# ╔═╡ 2e347214-cf7b-452f-a041-ad117d869a16
begin
	K = 3 																	# scale factor for the current vector
	I⃗ₙ = (K*Iₙ)∠(φₙ)
	U⃗ₙ = (Uₙ/√3)∠(0)
	RₛI⃗ₙ = (Rₛ*Iₙ)∠(φₙ)
	jXₛI⃗ₙ = (Xₛ*Iₙ)∠(φₙ+90)
	plot([0, U⃗ₙ], arrow=:closed, legend=:topleft, label="U∠0°")
	plot!([0, I⃗ₙ], arrow=:closed, label="Iₙ∠φ")
	plot!([U⃗ₙ, U⃗ₙ+RₛI⃗ₙ], arrow=:closed, label="RₛIₙ∠φ")
	plot!([U⃗ₙ+RₛI⃗ₙ, U⃗ₙ+RₛI⃗ₙ+jXₛI⃗ₙ], arrow=:closed, label="XₛIₙ∠(φ+90°)")
	plot!([0, E⃗₀ₙ], arrow=:closed,
		  minorticks=5, label="E₀∠δ",
		  ylims=(-800,800), xlims=(0,1600), size=(600,600))
end

# ╔═╡ 6ff6db51-637d-49c6-815f-e179a9c4ffd5
begin
	# locus of stator thermal limit:
	ϕ = -10:1:190
	S_locus = (Sₙ)∠.(ϕ)
	plot(S_locus, 
		label="limite térmico do estator", title="Diagrama P-Q",
		linewidth=2, legend=:bottomleft, minorticks=5,
		size=(600,600), xlims=(-1500e3,1500e3), ylims=(-1500e3,1500e3))
		
	# locus of the rotor thermal limit:
	U = Uₙ/√3
	Q = -3*U^2/Xₛ
	DE = 3*U*E₀ₙ/Xₛ
	ψ = -15:1:15
	R_locus = Q.+((DE)∠.(ψ))
	plot!(R_locus, label="limite térmico do rotor", linewidth=2)
	
	# locus of the turbine:
	plot!([-1500e3+j*Pab*1000, 1500e3+j*Pab*1000], 
		label="limite mecânico da turbina",	linewidth=2)
	
	# axis: kW, kVAr
	plot!([-1500e3+j*0, 1500e3+j*0], arrow=:head,
		label="eixo de potência reactiva (VAr)",
		linecolor=:black, linewidth=2)
	plot!([-j*1500e3, j*1500e3], arrow=:head,
		label="eixo de potência activa (W)",
		linestyle=:dash, linecolor=:black, linewidth=2)
end

# ╔═╡ 9d9ab479-b525-41ee-84ac-7fe5d88b6dfc
begin
	I = 0:10:1.5*Iₙ
	cosφ₁ = 0.8
	φ₁ = -acos(cosφ₁)
	Z⃗ₛ = Rₛ+j*Xₛ
	Zₛ = abs(Z⃗ₛ)
	θ = angle(Z⃗ₛ)
	E⃗₀₁ = (Uₙ/√3)∠(0) + (Z⃗ₛ)*((Iₙ)∠(φ₁*180/π))
	E₀₁ = abs(E⃗₀₁)
	δ₁ = asin.((Zₛ/E₀₁).*I*sin(θ+φ₁))  		# δ: load angle, radians
	U₁ = E₀₁*cos.(δ₁) .- Zₛ.*I*cos(θ+φ₁)  	# calculation of load characteristic
	U₁c = U₁*√3
end

# ╔═╡ da103e2c-d418-4704-968a-39943de1391c
begin
	E₀ = 2500/√3
	δ₄ = asin.((Zₛ/E₀).*I*sin(θ+φ₁))  		# δ: load angle, radians
	U₄ = E₀*cos.(δ₄) .- Zₛ.*I*cos(θ+φ₁)  	# calculation of load characteristic
	U₄c = U₄*√3
end

# ╔═╡ f1cb6ed1-a8d8-439d-be7e-f3f62acc67d2
begin
	cosφ₂ = 0.8
	φ₂ = acos(cosφ₂)
	E⃗₀₂ = (Uₙ/√3)∠(0) + (Z⃗ₛ)*((Iₙ)∠(φ₂*180/π))
	E₀₂ = abs(E⃗₀₂)
	δ₂ = asin.((Zₛ/E₀₂).*I*sin(θ+φ₂))  		 # δ: load angle, radians
	U₂ = E₀₂*cos.(δ₂) .- Zₛ.*I*cos(θ+φ₂)	 # calculation of load characteristic
	U₂c = U₂*√3
end

# ╔═╡ 6dfefd2d-7a10-4b81-b1af-56aff856573d
begin
	δ₅ = asin.((Zₛ/E₀).*I*sin(θ+φ₂)) 		 # δ: load angle, radians
	U₅ = E₀*cos.(δ₅) .- Zₛ.*I*cos(θ+φ₂) 	 # calculation of load characteristic
	U₅c = U₅*√3
end

# ╔═╡ 947eaafe-4726-4c5a-92ec-27926dbf8e0a
begin
	φ₃ =0
	E⃗₀₃ =(Uₙ/√3)∠(0) + (Z⃗ₛ)*((Iₙ)∠(φ₃*180/π))
	E₀₃ = abs(E⃗₀₃)
	δ₃ = asin.((Zₛ/E₀ₙ).*I*sin(θ+φ₃))  	 		# δ: load angle, radians
	U₃ = E₀₃*cos.(δ₃) .- Zₛ.*I*cos(θ+φ₃)	 	# calculation of load characteristic
	U₃c = U₃*√3
end

# ╔═╡ d6f6628a-95aa-4860-bc54-3c065ca2d056
begin
	plot(I, U₁c, 
		title="U =f(I)",
		xlabel = "I(A)", ylabel="U(V)", 
		ylims=(0,3000), 
		framestyle = :origin, minorticks=5, label="cosφ=0.8(i)",
		legend=:bottomleft)
	plot!(I, U₃c, label="cosφ=1")
	plot!(I, U₂c, label="cosφ=0.8(c)")
end

# ╔═╡ 5146f962-549c-45c5-93e1-a51f5045724d
begin
	δ₆ = asin.((Zₛ/E₀).*I*sin(θ+φ₃))  		# δ: load angle, radians
	U₆ = E₀*cos.(δ₆) .- Zₛ.*I*cos(θ+φ₃)  	# calculation of load characteristic
	U₆c = U₆*√3
end

# ╔═╡ ae2ce7ad-3670-4691-9f90-1ac77d60259f
begin
	plot(I, U₄c, 
		title="U =f(I)",
		xlabel = "I(A)", ylabel="U(V)", 
		ylims=(0,3000), 
		framestyle = :origin, minorticks=5, label="cosφ=0.8(i)",
		legend=:bottomleft)
	plot!(I, U₅c, label="cosφ=1")
	plot!(I, U₆c, label="cosφ=0.8(c)")
end

# ╔═╡ eb60cb8c-6773-455b-badb-3baa4266efa8


# ╔═╡ a8a21207-28b4-4372-9404-177a81b59e83
md"""
## *Setup*
"""

# ╔═╡ 95125cfb-d225-4e38-957f-f53d6d206db7
md"""
Documentação das bibliotecas `Julia` utilizadas:  [Dierckx](https://github.com/kbarbary/Dierckx.jl), [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/).
"""

# ╔═╡ e4974853-db6a-4b66-8552-908345633574
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ 5fa87f53-c4a9-4320-91cd-a7e26bc138b5
TableOfContents(title="Índice")

# ╔═╡ 765ddc37-963d-4963-a276-d8728473171e
md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""

# ╔═╡ e10f6d8e-3810-4824-9233-a1193615f22d
md"""
|  |  |
|:--:|:--|
|  | This notebook, [CurvesSynGen.jl](https://ricardo-luis.github.io/me-2/CurvesSynGen.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dierckx = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Dierckx = "~0.5.4"
Plots = "~1.40.17"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.69"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "5510b5b95403a33cbd6110dcc9fd828ed1c0785f"

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

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "5ac098a7c8660e217ffac31dc2af0964a8c3182a"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "2.0.0"

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

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

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

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4e1fe97fdaed23e9dc21d4d664bea76b65fc50a0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.22"

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

[[deps.Dierckx]]
deps = ["Dierckx_jll"]
git-tree-sha1 = "7da4b14cc4c3443a1afc64abee17f4fcb45ad837"
uuid = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
version = "0.5.4"

[[deps.Dierckx_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3251f44b3cac6fec4cec8db45d3ab0bfed51c4d8"
uuid = "cd4c43a9-7502-52ba-aa6d-59fb2a88580b"
version = "0.2.0+0"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

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

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "e09121f4c523d8d8d9226acbed9cb66df515fcf2"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.10.4"

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

[[deps.LoweredCodeUtils]]
deps = ["CodeTracking", "Compiler", "JuliaInterpreter"]
git-tree-sha1 = "73b98709ad811a6f81d84e105f4f695c229385ba"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.4.3"

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
git-tree-sha1 = "87510f7292a2b21aeff97912b0898f9553cc5c2c"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

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

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "5d9ab1a4faf25a62bb9d07ef0003396ac258ef1c"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.15"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "2d7662f95eafd3b6c346acdbfc11a762a2256375"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.69"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

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

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "20ccb7e2501e9da93fe8450d01aeabf16a5f0c82"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.8.1"

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

    [deps.Revise.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

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
git-tree-sha1 = "b81c5035922cc89c2d9523afc6c54be512411466"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.5"

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
git-tree-sha1 = "0fc001395447da85495b7fef1dfae9789fdd6e31"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.11"

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
# ╟─04954281-6692-4c19-86a5-1f45a2107cc3
# ╟─b4536854-efd9-4ee4-957c-9743ec32aa65
# ╟─2911bd1b-2a50-412f-982c-30eb2b550e38
# ╟─a9743237-6408-406b-a8eb-9cbf8867f9ef
# ╟─4e44ac99-e751-49f0-a228-c8c34a2861f2
# ╠═42931953-b637-42f5-b451-ab374a89ea70
# ╟─ab85c3a5-f0b1-4d66-b162-4561a02e82b5
# ╟─cb5bcb47-51c3-4a3c-bdbc-581e37f82e80
# ╟─d18c19c9-2bd8-4e68-8b0c-bcf9a7fadfe2
# ╟─b2cfb3de-c46b-40c5-b982-da47b62a0628
# ╟─c88ac310-ece1-4738-b936-0fcfde134810
# ╟─38fa3ee4-4435-40b9-a47a-ce8292535d75
# ╠═c64c2444-bb8b-4c52-960e-4c41445a98ca
# ╟─24ae7ecd-9423-4edf-bf88-6e71f0e27d82
# ╠═825f12d2-9153-4ee1-9d83-640f49d88d6d
# ╟─93e6e95e-8d12-450d-9558-ef2780de56f8
# ╟─4da8eaa3-0c65-4351-9242-adfc95af7353
# ╟─4d2962a9-0816-4b25-ae7b-f3c87d375428
# ╠═e29ade22-1092-4a05-b078-d5d50509b875
# ╟─ab03c270-6924-4c14-9375-3ae600b39250
# ╟─a30977b0-751f-437d-b185-55127263b6bc
# ╠═2e347214-cf7b-452f-a041-ad117d869a16
# ╟─c31adb10-b16b-45f3-9f06-ea5c68396dc8
# ╟─f1abeadc-7d88-4cb3-8998-c4242460191e
# ╟─02deedfc-2306-470b-9a16-63b45a5ae638
# ╟─c08ae18e-7857-4dd0-b157-462ef9ab2c34
# ╠═a7d1c835-2494-45ed-a8b2-a2cc89fb8636
# ╠═c653686d-f8d8-48c0-87dd-0b3c8027ce6a
# ╟─b81dee37-67b6-4904-a0ce-1f6bdb48de2d
# ╟─3d61fd46-c01c-4c9a-ad5a-6182e8adef45
# ╟─593c3b9a-76be-4fe3-8f9d-baaf86035b8c
# ╟─3619a6e1-1015-46ef-9dcf-ddd44e0bdb63
# ╠═4d172d04-2412-48cf-8136-ccce4fdb0c61
# ╟─4d673ff6-e368-4c26-88dd-bc105a96e7c6
# ╟─4c577232-2e70-4b9f-9ab6-c24b66824b81
# ╟─5de1389d-a54c-48f0-9c93-4cf46c4c5a4a
# ╟─840f2ac8-2282-4cc7-8422-f7e1c078c7e9
# ╠═6ff6db51-637d-49c6-815f-e179a9c4ffd5
# ╟─ffdfe498-9c29-44a1-b31e-19f17b0ba3ab
# ╟─02f9cc22-91c5-4b01-90bc-3359008b6dc7
# ╟─7111bdc6-fab3-48be-89c1-3ce91de11c57
# ╟─2b5da421-a849-4d34-b7d8-1acade30ee21
# ╠═9d9ab479-b525-41ee-84ac-7fe5d88b6dfc
# ╟─58caf67b-b57d-47d2-b210-b86e662d117e
# ╠═f1cb6ed1-a8d8-439d-be7e-f3f62acc67d2
# ╟─ab07ed6e-e3da-469c-a4e9-dfd9524869ce
# ╠═947eaafe-4726-4c5a-92ec-27926dbf8e0a
# ╟─d6f6628a-95aa-4860-bc54-3c065ca2d056
# ╟─52f522dd-7e25-4841-92b2-7b54ca1040cf
# ╟─19a1c85d-25af-4aeb-ad7b-2d19396bde89
# ╟─9c27b79c-2c53-44f0-b5e1-5d62570c3ba4
# ╠═da103e2c-d418-4704-968a-39943de1391c
# ╟─5530ca56-7421-4521-abeb-566a8bdb9756
# ╠═6dfefd2d-7a10-4b81-b1af-56aff856573d
# ╟─c4698c03-47e3-4cb1-9817-a29618327303
# ╠═5146f962-549c-45c5-93e1-a51f5045724d
# ╟─ae2ce7ad-3670-4691-9f90-1ac77d60259f
# ╟─9be1b929-edba-41ca-b970-4efcf6ec63c7
# ╟─68888153-d958-42a9-abd7-463d0b42223b
# ╟─1884eeff-905c-4ad0-a940-5822aacfd73b
# ╟─60ecdb18-d321-48e8-8622-e74960675b3f
# ╟─66d23e11-bab8-4282-a356-e27a97985a41
# ╟─b689e21d-ff9b-412f-b195-3a3fc56b434b
# ╟─8390d93f-f542-4ac2-9b07-6aae685105af
# ╟─2abb9621-8af2-48fa-b6d9-72922f6166a9
# ╠═00ded203-b6a6-4c1d-a6c4-9b7c97eae79d
# ╟─eb60cb8c-6773-455b-badb-3baa4266efa8
# ╟─a8a21207-28b4-4372-9404-177a81b59e83
# ╟─95125cfb-d225-4e38-957f-f53d6d206db7
# ╠═46957491-f987-44b2-aa8c-a4215fd534ec
# ╟─e4974853-db6a-4b66-8552-908345633574
# ╠═5fa87f53-c4a9-4320-91cd-a7e26bc138b5
# ╟─765ddc37-963d-4963-a276-d8728473171e
# ╟─e10f6d8e-3810-4824-9233-a1193615f22d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
