### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["lecture", "module3"]
#> title = "Teste 27.jan.2023"
#> description = "Apresenta-se a resolução de um teste sobre máquinas síncronas 3~ dividido em dois problemas. O primeiro analisa um sistema com dois alternadores síncronos em paralelo alimentando uma carga. Inclui a determinação experimental das reatâncias síncronas segundo os eixos direto e de quadratura, verificação da sequência de fases, repartição equitativa de carga e operação como condensador síncrono. O segundo problema estuda um motor síncrono 3~ de polos lisos. Abrange o cálculo da FCEM, análise de diagramas vetoriais com variação da corrente de campo, e aplicação do critério de igualdade das áreas."
#> chapter = 2
#> section = 7
#> image = "https://github.com/Ricardo-Luis/me-2/blob/d9f7ad7865fae9fada974064432a273f751697ed/images/card/Test.ACmachines.png?raw=true"
#> layout = "layout.jlhtml"
#> date = "2026-09-11"
#> order = 7
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

# ╔═╡ b88eb231-8e1b-4211-bb68-9f3b2b78fb10
using Plots, PlutoUI, PlutoTeachingTools, Roots, Dierckx
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - Roots.jl,  simple routines for finding roots, or zeros, of scalar functions
  - Dierckx.jl, tool for data interpolation
=#

# ╔═╡ eab2de41-f779-4705-a3cf-456c615d4fd5
Columns(md"""
	`Test.ACmachines.jl`""", md"""
	`Language:` $(@bind lang Select([
		"pt" => "Português",
		"en" => "English",
		]))""", md"""
	`Last update: 11·09·2026`""")

# ╔═╡ 40083415-01b1-4570-bd6a-2c25e4cf4673
md"""
$\textbf{Licenciatura em Engenharia Eletrotécnica }$

$\text{MÁQUINAS ELÉTRICAS 2}$ 

$\textbf{Rep. do 2º Teste (do Exame de Época Normal de 27 de janeiro de 2023)}$ 
---
"""

# ╔═╡ 4b2410af-4cb1-4e68-b745-e68625b514f6
md"""
$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Resolução de teste sobre máquinas elétricas síncronas trifásicas}}}$
"""

# ╔═╡ 263cc10b-55d4-47bd-8a6c-dcdacc4cdf3d


# ╔═╡ 0262a34b-95f8-453e-812c-43663d6337b2
md"""
VERSÃO DRAFT !

**To do:**

 $(@bind thing1 CheckBox()) tornar o texto mais didático\
 $(@bind thing2 CheckBox()) _do the English version_\
 $(@bind thing3 CheckBox()) adicionar bibliografia para algumas questões\
 $(@bind thing4 CheckBox()) circuitos com os métodos das lâmpadas\
 $(@bind thing5 CheckBox()) adicionar comentários nos códigos\
 $(@bind thing6 CheckBox()) tornar a explicação do condensador síncrono interativa, através da modificação do diagrama vetorial\
 $(@bind thing7 CheckBox()) acrescentar linhas P=constante, II-b)\

"""

# ╔═╡ 5a58ddf6-b17e-4c34-bae5-2aa60245a9c3


# ╔═╡ 47a00c38-b9d7-4515-8b4b-3bca0d107e6c
md"""
# I - Alternador síncrono de polos salientes
"""

# ╔═╡ 236fc3f7-321e-44f7-8ab7-18098ff1b22b
md"""
Considere a alimentação de uma carga de $\rm 1MVA$, $cos\varphi=0,7(i)$, por intermédio de uma ligação em paralelo de dois alternadores síncronos trifásicos, em que se consideram desprezáveis as perdas.

|               |         |       |         |       |                  |                 |
|--------------:|--------:|------:|--------:|------:|-----------------:|----------------:|
| Alternador 1: | $\rm 1kV-Y$; | $\rm 50Hz$; | $\rm 750kVA$; | $p=1$;  | $X_s=4,00Ω⁄fase\:\:$    |                 |
| Alternador 2: | $\rm 1kV-Y$; | $\rm 50Hz$; | $\rm 800kVA$; | $p=12$; | $X_d=1,85Ω⁄fase$; | $X_q=1,25Ω⁄fase$ |

"""

# ╔═╡ 9b6e6867-c94e-4e8e-8743-82e51f320901
md"""
# Dados:
"""

# ╔═╡ 1a6abf20-e5d3-436a-bdc2-f99110ce4956
Sₗ, cosφₗ = 1e6, 0.7 			# load data: apparent power, power factor (indutive) 

# ╔═╡ 0084d746-bb78-4575-8ae7-4fbc8e072810
Uc₁, f₁, Sₙ₁, p₁, Xₛ₁ = 1000, 50, 750e3, 1, 4/10			# alternator 1 datasheet

# ╔═╡ d968ea56-b785-4ec4-a3fe-51b8cf46bb0f
Uc₂, f₂, Sₙ₂, p₂, Xd, Xq = 1000, 50, 800e3, 12, 1.85, 1.25	# alternator 2 datasheet

# ╔═╡ cbffc42a-b2d9-4f0a-b0e6-32869e629de4


# ╔═╡ a4aa3362-ce8c-48ba-a840-9e6e8f8718a3
md"""
## a) $X_d$ e $X_q$
**Como se determinam os parâmetros $X_d$ e $X_q$ experimentalmente? Esclareça sucintamente;**
"""

# ╔═╡ 6b429d28-58a9-49d9-b0d4-e48927edb3de
md"""
Ensaio de pequeno escorregamento:
- aplica-se uma tensão reduzida ao estator através de auto-transformador
- aciona-se o rotor a uma velocidade ligeiramente diferente da velocidade de sincronismo
- registam-se num osciloscópio as formas de onda da tensão e da corrente de uma das fases do estator
- Das envolventes às curvas anteriores, calculam-se as reatâncias síncronas segundo os eixos direto e de quadratura:

$X_d=\frac{U_{max}^{env}}{I_{min}^{env}}\quad\quad; \quad\quad X_q=\frac{U_{min}^{env}}{I_{max}^{env}}$ 

"""

# ╔═╡ 1dca324c-2a26-4da8-9e17-f10bc01a7300


# ╔═╡ c5904d62-a2ab-4298-bcb2-a398c89ef77c
md"""
### Calculos aux. ensaio de escorregamento
Apenas para representação da figura!
"""

# ╔═╡ bd4783a6-936c-4700-bbf8-74b632eb8328
#= 
Implementation of "Amplitude Modulation technique" to emulate salient pole synchronous machine slip test:
  - Carriers amplitudes: Ac1, Ac2 [pu]
  - Modulation amplitudes: Am1, Am2 [pu]
  - Carrier frequency: fc = 50 Hz (represents the rotating magnetic field frequency)
  - Modulation frequency: fm [Hz] (represents the double of slip frequency, or the double of the difference between the rotating magnetic field and the rotor speed and in Hz)
=#
Ac1, Ac2, Am1, Am2, fc, fm = 0.3,0.45, 0.04, 0.15, 50, 3

# ╔═╡ b6813c43-a2b4-42f7-85c3-111f6ff48767
begin
	t = 0:0.0001:0.9  	# time span, s
	γ = π/3 			# initial phase, rad
	voltage = Ac1*cos.(2π*fc.*t.+γ) + Am1*cos.(2π*fm.*t.+γ).*cos.(2π*fc.*t.+γ)
	current = Ac2*cos.(2π*fc.*t.+γ.+π) + Am2*cos.(2π*fm.*t.+γ.+π).*cos.(2π*fc.*t.+γ.+π)
	field = Am2*cos.(π*fm.*t.+2γ)
end;

# ╔═╡ 53284387-5f8b-4838-ba77-2c69c58c73eb
begin
	#plot()	# backend for interactive graph
	
	v1=plot(t, voltage, ylims=(-0.4,0.4),
		ylabel="U (pu)", title="Ensaio de pequeno escorregamento")
	
	v2=plot(t, current, ylims=(-0.7,0.7), ylabel="I (pu)")
	
	v3=plot(t, field,  ylims=(-0.3,0.3), ylabel="Uᴶ⁻ᴷ (pu)", xlabel="t (s)")
	
	plot(v1, v2, v3, layout = (3, 1), legend=:false)
end

# ╔═╡ 3bdecd8a-708d-4bbf-811a-4f96e2f011b9
md"""
[Amplitude Modulation](https://www.tutorialspoint.com/analog_communication/analog_communication_amplitude_modulation.htm)


$$s(t)=A_c\left [ 1+\left ( \frac{A_m}{A_c} \right )\cos \left ( 2\pi f_mt \right ) \right ]\cos \left ( 2\pi f_ct \right )$$
"""

# ╔═╡ 039f5f54-872d-41ba-85a4-5c134a1a0c1b


# ╔═╡ 266ad8ad-9fca-415f-b8e6-026c4f481364
md"""
## b) Sequência de fases
**Explique como verifica a sequência de fases no procedimento de colocação dos alternadores em paralelo.**
"""

# ╔═╡ f6d5a921-021e-4ff4-9d75-6e6add431efb
md"""
- Pode-se usar um dos métodos das lâmpadas:
  - modo focos girantes: as lâmpadas acendem e apagam à vez
  - modo focos em extinção: as lâmpadas acendem e apagam simultaneamente 

Se num destes modos o comportamento das lâmpadas não corresponder ao esquema implementado é necessário proceder à troca de quaisquer 2 fases.

- em alternativa pode-se usar um sequencímetro, verificando à vez, em cada alternador a sua sequência de fases. 

"""

# ╔═╡ b00d70d1-a7fd-4c7f-90fe-a8722ad50b31


# ╔═╡ 26e6b2e7-ec1e-456e-848e-57af1f0a27dd
md"""
## c-1) Cálculo de $\bar{E_0}$ 
**Para uma repartição equitativa de carga, determine a força eletromotriz do alternador 2.**
"""

# ╔═╡ ff8ce092-49a1-4165-b621-246ad4335c81


# ╔═╡ 4e19252c-ab26-404f-b0da-4449fd0450b7
begin
	Iₗ₂ = (Sₗ/2) / (√3 * Uc₂)
	Iₗ₂ = round(Iₗ₂, digits=1) 		# A, line current for each alternator
end

# ╔═╡ e9074cf1-9a24-451e-aa64-cd948b15f9b6
begin
	φ₂ = -acos(cosφₗ)
	φ₂ = rad2deg(φ₂)
	φ₂ = round(φ₂, digits=1)
end

# ╔═╡ 253bfa2d-233a-4320-b8df-bdffd5501c43


# ╔═╡ 48c57f54-1cb3-43af-a853-f778d5f37ad8
md"""
## c-2) Diagrama vetorial de tensões 
**Trace qualitativamente o diagrama vetorial  para o alternador 2.**
"""

# ╔═╡ 0c8e08b0-2a1f-43f1-9bfa-a4a31d255ade


# ╔═╡ 9b1449bf-64d5-482c-9504-96a1638c8f62
md"""
## d) 💻  $\:U, \:f, \:Q, \:P$
**Quais os procedimentos a adotar neste paralelo de alternadores síncronos, para manter constantes a tensão, frequência e a repartição de carga, se a amplitude da corrente na carga paulatinamente aumentar? Justifique qualitativamente, apresentando gráficos que relacionem: U, f, Q, P**
"""

# ╔═╡ d21bcd53-f213-46cc-8e11-cfa336bf98aa
md"""
Considerando os alternadores acionados por turbinas de características iguais, permite assumir curvas de $f_1(P_1)$ e $f_2(P_2)$ iguais, considerando que os reguladores de frequência são idênticos. Assim, por exemplo, considerando um estatismo de $5\rm Hz/MW$ de cada regulador-turbina, podemos transformar esta questão qualitativa, numa questão quantitativa tirando partido do cálculo computacional para ilustrar graficamente o problema.
"""

# ╔═╡ f1cdf6dd-e704-4eec-8a01-92ee3965d626
md"""
 $\text{Alternadores 1 e 2, potência mecânica (pu):}\quad$ $(@bind Kmec PlutoUI.Slider(0.7:0.001:1.2, default=1.00,show_value=true))
"""

# ╔═╡ e993f8a1-5662-4f3b-b51b-8e0ef1fec76d


# ╔═╡ 5bf619b1-8756-4efd-9104-ea7bf7bcd079
md"""
Os alternadores considerados neste exercício têm parâmetros construtivos diferentes, por conseguinte, as curvas características $U_1(Q_1)$ e $U_2(Q_2)$ são diferentes. Tome-se como ponto de partida, a situação descrita em que repartem a carga reactiva de igual modo. Também aqui, podemos transformar esta questão qualitativa, numa questão quantitativa tirando partido do cálculo computacional para ilustrar graficamente o problema.
"""

# ╔═╡ 72c821fe-33e9-46a9-8414-076f14b7ab3f
md"""
 $\text{Ativar linhas de apoio para repartição equitativa de carga:}\quad$ $(@bind K3 CheckBox(default=false))
"""

# ╔═╡ 974731dd-ca12-42b8-9f82-9d1337cf319c
md"""
 $\text{Alternador 1, corrente de excitação (pu):}\quad$ $(@bind K1 PlutoUI.Slider(0.5:0.001:1.4, default=1,show_value=true))

 $\text{Alternador 2, corrente de excitação (pu):}\quad$ $(@bind K2 PlutoUI.Slider(0.5:0.001:1.4, default=1,show_value=true))
"""

# ╔═╡ 4eac8988-f5c8-44d5-8fad-2b127d55bc3c


# ╔═╡ dc9f5db7-38dc-4d41-a9de-b29b2ab6fb0f
md"""
!!! nota
	Neste exercício interativo, o estudante deverá compreender como atuar nos grupos alternadores para manter a frequência, tensão e repartição de carga constantes, quando a amplitude da corrente aumenta. 
		"""

# ╔═╡ 9c25ef0d-bfd4-4957-80a3-ff6a6fe9f858


# ╔═╡ 849a11aa-b172-428c-8b9a-a49879d70f80
md"""
### Cálulos auxiliares:
"""

# ╔═╡ a3a183a1-383d-446f-9ed4-c2925398061b
md"""
> Não necessita de preocupar-se em perceber esta secção em detalhe!
"""

# ╔═╡ 69d15fb8-85f8-4bec-a647-dc07afc8ba3c
begin
	Iₗ=Sₗ/(√3*Uc₁)
	Iload=0:Iₗ/100:3*Iₗ 				# total load variation
end;

# ╔═╡ cddb2d07-a783-4897-a7dd-1e81cdd86df0
md"""
#### $f(P)$
"""

# ╔═╡ 661f99ef-de1c-4b53-a26d-e07e92badc52
begin
	Pₗ = Sₗ*cosφₗ/1e6 		 	# MW, load active power
	fₗ = 50 					# Hz, desired frequency of the load/grid
	sₚ = 5 						# Hz/MW, frequency slope of the prime-mover
	f₀ = sₚ * (Pₗ/2) + fₗ       # Hz, no-load frequency (half-load is considered for each alternator)
end

# ╔═╡ a99ee5e5-334f-4125-9032-f14b070373cc
md"""
 $P,\: \text{carga ativa total (MW):}\quad$ $(@bind P PlutoUI.Slider(0:0.01:2, default=Pₗ,show_value=true))
"""

# ╔═╡ a752ef6e-b021-437c-9942-fa44887ee3d9
begin
	Pₗ₂ = √3*Uc₂*cosφₗ.*(Iload*0.5)/1e6
	fₗ₂ = f₀ .- sₚ .* Pₗ₂
	Pₗ₁ = - Pₗ₂ 
	fₗ₁ = f₀ .+ sₚ .* Pₗ₁
end;

# ╔═╡ f083fcc7-d4d6-49ba-a6cf-27417a9d2a32
begin
	fₚ = f₀ - sₚ*P/2
	fₚ = round(fₚ, digits=2)
end;

# ╔═╡ 12fb6b85-6e04-4dbc-bb04-6ff10e2da2f5
md"""
 $$\quad f=$$ $(fₚ) $$\rm Hz\quad$$ $$\quad P_1=P_2=$$ $(P/2) $$\rm MW$$
"""

# ╔═╡ ff6964bd-9f21-42c2-8f15-c6b30330c169
begin
	fₗ₂ʼ = f₀*Kmec .- sₚ .* Pₗ₂
	fₗ₁ʼ = f₀*Kmec .+ sₚ .* Pₗ₁
	fₚʼ = f₀*Kmec - sₚ*P/2
	fₚʼ = round(fₚʼ, digits=2)
end;

# ╔═╡ c71d7953-dc87-4f39-bc50-e76a63a53fcf
begin
	# f(P) alternator prime-mover curves
	plot(Pₗ₁, fₗ₁, framestyle=:zerolines, linewidth=2, linecolor=:red, 
		label="f₁ = f(P₁)", xlim=[-1,1], ylim=[0,60],
		xticks=(-1:0.2:1, [1 0.8 0.6 0.4 0.2 0 0.2 0.4 0.6 0.8 1.0]))
	plot!(Pₗ₂, fₗ₂, linewidth=2, linecolor=:blue, label="f₂ = f(P₂)", 
		ylabel="f (Hz)", xlabel="P (MW)")

	#Initial conditions: line markers for each alternator with 50% of load @ 50Hz
	plot!([-Pₗ/2, Pₗ/2],  seriestype = :vline,
		linestyle=:dashdot, linecolor=:black, label=:none)
	plot!([fₗ],  seriestype = :hline,
		linestyle=:dashdot, linecolor=:black, label=:none)

	# effect of load variation:
	plot!([fₚ], seriestype = :hline,
		linestyle=:dash, linecolor=:black, label=:none)
	plot!([-P/2, P/2],  seriestype = :vline,
		linestyle=:dash, linecolor=:black, label=:none)

	# frequency correction with equity load sharing

	plot!(Pₗ₁, fₗ₁ʼ, linewidth=2, linecolor=:red, linestyle=:dash,
		label="f'₁ = f(P₁)")
	plot!(Pₗ₂, fₗ₂ʼ, linewidth=2, linecolor=:blue, linestyle=:dash, 
		label="f'₂ = f(P₂)")
	
end

# ╔═╡ 75e477a5-e856-4ad6-a659-ac02e58ecf8a
md"""
 $$\quad f'=$$ $(fₚʼ) $$\rm Hz\quad$$ $$\quad P'_1=P'_2=$$ $(P/2) $$\rm MW$$
"""

# ╔═╡ 57c7d7f0-0b06-4f3f-8403-e8867b6f4fc4
md"""
#### $U(Q)$
"""

# ╔═╡ 5ce13622-87c3-40ed-97a2-58591f6f9514


# ╔═╡ 55b1dd0d-8a3c-45b5-8681-7388fdcc7de5
md"""
## e) Condensador síncrono
**Explique sucintamente o que é um condensador síncrono. Considere que o alternador 2 é colocado nessa função e trace qualitativamente o novo diagrama vetorial correspondente**
"""

# ╔═╡ 76db2f36-7b1c-4472-a3e6-ca1c4520b28e
md"""
Condensador síncrono == motor em vazio sobreexcitado (gera indutiva/consome capacitiva)
"""

# ╔═╡ 882151a2-8110-4829-9b4b-f6a47e9aa6be


# ╔═╡ b8492061-7322-4af8-a885-1dbbb36f2f36
md"""
# II - Motor síncrono 3~ de polos lisos
"""

# ╔═╡ 52f3510a-0d30-4794-8ea7-c9dce2a214e0
md"""
**Considere um motor síncrono trifásico tetrapolar, $315\rm kW$, $\:690/400\rm V - 50\rm Hz$, $\:\eta=92\%$, $\:\rm cos\:\varphi=0,85(\rm c)$, ligado em triângulo a uma rede elétrica de $\:U, f\:$ constantes. A resistência estatórica é desprezável e apresenta uma reatância síncrona de $\:1,2\rmΩ/fase$.**
"""

# ╔═╡ aac2ef1d-67b8-4cee-a5ec-b0fb6c257455


# ╔═╡ 5f5d43aa-766d-4bb8-bcf9-4cb76b34c6bc
md"""
# Dados:
"""

# ╔═╡ 0f0a91cc-922e-4788-857c-156859f63f0e
Pᵤ, Uₛₜₐᵣ, U▵, f, η, cosφ, R, Xₛ = 315e3, 690, 400, 50, 0.92, 0.85, 0, 1.2

# ╔═╡ a21fe332-d5f1-4fff-90ab-95380fa29ae4


# ╔═╡ 693a2aae-fc42-43d5-8745-2b397892a7a0
md"""
## a) Cálulo de $\bar{E'_0}$ 
**Com o motor a operar nas condições nominais, determine o vetor da força eletromotriz e trace qualitativamente o diagrama vetorial correspondente;**
"""

# ╔═╡ fbb03be0-96c7-4114-9b7e-80fef92bd804


# ╔═╡ 8b14d6b5-6aac-4507-8ae8-1b2823b314fd
md"""
## b) 💻 Diagramas vetoriais 
**Trace qualitativamente o diagrama vetorial de tensões correspondente à situação nominal e apresente nos eixos relativos a $P(\delta)\:$ e $\:Q(\delta)$ o ponto de funcionamento;** 

**Suponha agora uma redução em 50% na corrente de campo. Trace qualitativamente e sobreposto ao diagrama anterior, um novo diagrama vetorial referente a esta modificação e apresente nos eixos relativos a $P(\varphi)$ e $Q(\varphi)$ o novo ponto de funcionamento.**
"""

# ╔═╡ a25f59a4-d20b-49d6-ac6f-53899279f9a7
md"""
 $\text{Corrente de excitação (pu):}\quad$ $(@bind Kc PlutoUI.Slider(0.488:0.001:1.5, default=0.5,show_value=true))
"""

# ╔═╡ bd899d78-df7b-4770-b43a-965ab1ac11e0


# ╔═╡ 7b68f211-36b3-4577-9d9e-763b14ef95d7
md"""
## c) 💻 Critério de igualdade das áreas
**O limite de estabilidade dinâmica, ou de grandes variações, é encontrado através do critério de igualdade das áreas. Desenvolva a equação (sem resolver os integrais) e as relações que permitem encontrar a potência limite a aplicar à máquina síncrona, sabendo que esta se encontra inicialmente em vazio, com tensão nominal.**
"""

# ╔═╡ 8ece1d58-d4aa-441f-ae69-d25685670472


# ╔═╡ 3718458e-0f67-42cd-a27d-317ee0906145
md"""
 $$P_{\text{lim}},\:\rm kW:$$ $(@bind Pₗᵢₘ PlutoUI.Slider(1:1:350, default=150, show_value=true))
"""

# ╔═╡ 1dca9b65-07bf-4c52-b691-65ae0147887c
md"""
Aplicando o critério da igualdade das áreas, $$A_1 = A_2$$, escrevem-se as equações de cálculo das áreas igualando-as, de modo a obter uma equação final, que apresenta uma única incógnita, $$\delta_{\text{lim}}$$, que satisfaz a igualdade das áreas.
"""

# ╔═╡ d81ab12b-6339-477c-b69c-0981ca04d1d2
md"""
Aproveitando o cálculo computacional, estendeu-se esta questão para obter solução do problema, resolvendo os integrais. Assim, tem-se:
"""

# ╔═╡ 24236092-6fa3-4c86-b70c-f4f32c15d14d
HTML("""
<div style="overflow-x: auto; padding: 10px;">
$(repr("text/html", md"""
$$\begin{aligned} 
A_1 &= A_2 \\
\\
P_{\text{lim}} \delta_{\text{lim}} - \int_{0}^{\delta_{\text{lim}}} P(\delta) \, \mathrm{d}\delta &= \int_{\delta_{\text{lim}}}^{\pi - \delta_{\text{lim}}} P(\delta) \, \mathrm{d}\delta - P_{\text{lim}}(\pi - 2\delta_{\text{lim}}) \\
\\
(P_{\max} \sin\delta_{\text{lim}})\delta_{\text{lim}} - P_{\max}\int_{0}^{\delta_{\text{lim}}}\sin\delta \, \mathrm{d}\delta &= P_{\max}\int_{\delta_{\text{lim}}}^{\pi - \delta_{\text{lim}}} \sin\delta \, \mathrm{d}\delta - (P_{\max} \sin\delta_{\text{lim}})(\pi - 2\delta_{\text{lim}}) \\
\\
(\sin\delta_{\text{lim}})\delta_{\text{lim}} - \bigl[-\cos\delta\bigr]_{0}^{\delta_{\text{lim}}} &= \bigl[-\cos\delta\bigr]_{\delta_{\text{lim}}}^{\pi - \delta_{\text{lim}}} - (\sin\delta_{\text{lim}})(\pi - 2\delta_{\text{lim}}) \\
\\
(\sin\delta_{\text{lim}})(\pi - \delta_{\text{lim}}) - 1 + \cos(\pi - \delta_{\text{lim}}) &= 0
\end{aligned}$$
"""))
</div>
""")

# ╔═╡ 8330caa4-d7b9-476b-92d9-38f0b64af425
md"""
Definindo uma função, $$g(\delta)$$: 

$$g(\delta) = (\sin\delta_{\text{lim}})(\pi - \delta_{\text{lim}}) - 1 + \cos(\pi - \delta_{\text{lim}})$$
A resolução da equação que satisfaz o critério de igualdade das áreas consiste em encontrar a raíz para $$g(\delta)=0$$:
"""

# ╔═╡ 706c07f0-eebb-4f71-8a4d-3093b1c79af9
begin
	# função a determinar a raíz: f(δ), [package: Roots.jl]
	g(δa) = (sin(δa))*(π-δa)-1+cos(π-δa)
end;

# ╔═╡ a19492ac-cc05-4f3b-9789-4f6cee8d9439
begin
	 # Calculation of δ that gives equal areas [package: Roots.jl]
	 δₛₒₗ=find_zero(g, (0, π/2))	# find g(δ)=0 betweem δᵢ to π/2, [Roots.jl]
	 δₛₒₗ=rad2deg(δₛₒₗ)
	 δₛₒₗ=round(δₛₒₗ, digits=2)
 end;

# ╔═╡ 714edc82-b6f7-4b88-b345-c9578f83ff30
md"""
A determinação da raíz para $$f(\delta)$$ corresonde à solução do critério da igualdade das áreas, $$A_1$$ e $$A_2$$.

Assim, com recurso a método numérico computacional, o ângulo de carga correspondente a $$f(\delta)=0$$, vem dado por: $$\delta_{\text{lim}}=$$ $δₛₒₗ $$°$$.
"""

# ╔═╡ e178a306-05a2-4fcb-8101-db1d4fd11cf4


# ╔═╡ 04c34d5b-7cb9-418a-84a5-6ec900cefa58
md"""
---
`ISEL/DEEEA/GDME/Máquinas Elétricas II`
"""

# ╔═╡ d6c33c3b-3823-4091-a397-5b78212d33d4


# ╔═╡ 42f5ca5e-e0c8-46d2-937a-93929b833271
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
	lang_code = lang == "pt" ? "pt-PT" : lang
	#lang_code = "pt-PT"
	
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

# ╔═╡ 1a5bf852-377d-4a42-9c31-b0fb0d4183ae
md"""
# *Notebook*
"""

# ╔═╡ 53087350-c94f-41e3-a0e3-9ad6a54f1d7e
md"""
## Notação complexa
"""

# ╔═╡ 0ca024ef-9fe9-41e6-a87e-feaddc80191f
j = Base.im   													# to use "j" as imaginary unit instead the Julia default "im"

# ╔═╡ aecd1555-ed11-4ab0-ad3d-98ada78f45a7
∠(θ) = cis(deg2rad(θ)) 											# to use phasor notation (with angle in degrees )

# ╔═╡ 052e8a6e-dd54-4079-b112-6b5275cfd6bb
begin
	I₂ = Iₗ₂
	I⃗₂ = (Iₗ₂)∠(φ₂)
	
	U⃗₂ = (Uc₂/√3)∠(0)   			# Y connection
	U₂ = abs(U⃗₂)
	U₂ = round(U₂, digits=1)
	Text("U⃗₂=$(U₂)V∠$(0)°")
end

# ╔═╡ d4defde1-3d5f-4473-b9f6-24322d92fdd8
begin
	E⃗₂ = U⃗₂ + j*Xq*I⃗₂
	E₂ = abs(E⃗₂)
	E₂ = round(E₂, digits=1)
	δ₂ = angle(E⃗₂)
	δ₂ = rad2deg(δ₂)
	δ₂ = round(δ₂, digits=1)
	Text("E⃗₂=$(E₂)V∠$(δ₂)°")
end

# ╔═╡ c0c59b61-943e-4ed0-935c-ec5cdf665b0d
begin
	I⃗d = (I₂*sind(abs(φ₂)+δ₂))∠(δ₂-90)
	Id = abs(I⃗d)
	Id = round(Id, digits=1)
	d_axis = angle(I⃗d)
	d_axis = rad2deg(d_axis)
	d_axis = round(d_axis, digits=1)
	Text("I⃗d=$(Id)A∠$(d_axis)°")
end

# ╔═╡ b44937d1-b83a-417b-a153-679d388adb59
begin
	E⃗₀₂ = E⃗₂ + j*(Xd-Xq)*I⃗d
	E₀₂ = abs(E⃗₀₂)
	E₀₂ = round(E₀₂, digits=1)
	let δ₂ = angle(E⃗₀₂)
		δ₂ = rad2deg(δ₂)
		δ₂ = round(δ₂, digits=1)
		Text("E⃗₀₂=$(E₀₂)V∠$(δ₂)°")
	end
end

# ╔═╡ 3398ead4-b619-4215-a05c-b68399c20c53
begin
	Qload⁵⁰=abs.(√3*Uc₂*Iload*0.5*sin(φ₂*π/180))/1000  #kVAr

	m2 = (E₀₂-Uc₂)/(-Qload⁵⁰[51])
	Uₐ₂=m2.*Qload⁵⁰ .+ E₀₂

	U2_int = Spline1D(Qload⁵⁰,Uₐ₂)
end;

# ╔═╡ 71e8be35-232f-4772-aca7-defe3cac3cd0
md"""
 $Q,\: \text{carga reativa total (kVAr):}\quad$ $(@bind Q PlutoUI.Slider(124:1:1400, default=2*Qload⁵⁰[51],show_value=true))
"""

# ╔═╡ 06f9ce73-97b1-4323-8960-e8616d1f8af1
begin

	# d, q axis:
	plot([0+j*0, (1100*cosd(δ₂))+j*1100*sind(δ₂)], 
		label="eixo de quadratura", arrow=:head, linecolor=:black, linewidth=2)
	plot!([0+j*0, (400*cosd(δ₂-90))+j*400*sind(δ₂-90)],
		label="eixo direto", arrow=:head, linecolor=:black, linewidth=2, linestyle=:dashdot)
	
	# E⃗':
	K=1 							# scale factor for the current vector
	jXqI⃗₂ = (Xq*I₂)∠(φ₂+90)
	plot!([0, U⃗₂], arrow=:closed, legend=:bottomright, label="U₂∠0°")
	plot!([0, K*I⃗₂], arrow=:closed, label="I₂∠φ₂")
	plot!([U⃗₂, U⃗₂+jXqI⃗₂], arrow=:closed, label="XqI₂∠(φ+90°)")
	plot!([0, E⃗₂], arrow=:closed, minorticks=5, label="E₂∠δ₂",
		  ylims=(-500,600), xlims=(0,1100), size=(600,600))

	# I⃗d
	plot!([0, I⃗d],arrow=:closed, label="Id∠(δ₂-90°)")
	
	#E⃗₀:
	plot!([E⃗₂, E⃗₂ + j*(Xd-Xq)*I⃗d], 
			arrow=:closed, label="(Xd-Xq)Id∠(δ₂)", linewidth=2)
	
	plot!([0, E⃗₀₂], arrow=:closed, label="E₀∠δ₂", linewidth=3)		
end

# ╔═╡ 1e113a09-77c3-44f2-af30-72a587396cb7
begin
	U⃗₁ = (Uc₁)∠(0)
	E⃗₀₁ = U⃗₁ + j*Xₛ₁*I⃗₂
	E₀₁ = abs(E⃗₀₁)
	E₀₁ = round(E₀₁, digits=1)

	m1 = (Uc₁-E₀₁)/(-Qload⁵⁰[51])
	Uₐ₁=m1.*(-Qload⁵⁰) .+ E₀₁

	U1_int = Spline1D(Qload⁵⁰,Uₐ₁)
end;

# ╔═╡ 1197f2e8-161b-4416-a8e8-621f7ebe3d6b
begin
	Q2 = (-m1*Q + E₀₁ - E₀₂)/(-m1+(m2))
	Q2=round(Q2, digits=1)
	
	U2=U2_int(Q2)
	U2=round(U2, digits=0)
end;

# ╔═╡ de8110e6-3caf-4169-9af9-55783689bc8c
begin
	Q1 = (abs(m2)*Q + abs(E₀₂ - E₀₁))/(m1+abs(m2))
	Q1=round(Q1, digits=1)

	U1=U1_int(Q1)
	U1=round(U1, digits=0)
end;

# ╔═╡ 14389231-1876-4015-8f1d-d7f5fa41a04c
md"""
 $$\quad U=$$ $(U1) $$\rm V\quad$$ $$\quad Q_1=$$ $(Q1) $$\rm kVAr\quad$$ $$\quad Q_2=$$ $(Q2) $$\rm kVAr\quad$$
"""

# ╔═╡ 2b7d5e66-78cb-43dc-884f-1df1a745764f
begin
	#Voltage correction:
	Uₐ₁ʼ=m1.*(-Qload⁵⁰) .+ K1*E₀₁
	Uₐ₂ʼ=m2.*Qload⁵⁰ .+ K2*E₀₂

	U1_intʼ = Spline1D(Qload⁵⁰,Uₐ₁ʼ)
	U2_intʼ = Spline1D(Qload⁵⁰,Uₐ₂ʼ)
end;

# ╔═╡ f164a7e0-2923-4154-802d-8128f5b06450
begin
	#Initial conditions: each alternator with 50% of load @ 1000V
	plot(Qload⁵⁰, Uₐ₂, xticks=(-1000:200:1000, 100*[10 8 6 4 2 0 2 4 6 8 10]),
		linewidth=2, linecolor=:blue, framestyle=:zerolines, xlim=[-1000,1000], label="U₂ = f(Q₂)")
	plot!(-Qload⁵⁰, Uₐ₁, ylim=[0,1600], linewidth=2, linecolor=:red, 
		yticks = 0:200:1600, label="U₁ = f(Q₁)")
	plot!([-Qload⁵⁰[51]], seriestype = :vline, 
		linestyle=:dashdot, linecolor=:black, label=:none)
	plot!([Qload⁵⁰[51]], seriestype = :vline, 
		linestyle=:dashdot, linecolor=:black, label=:none)
	plot!([1000], seriestype = :hline, 
		linestyle=:dashdot, linecolor=:black, label=:none, 
		ylabel="U (V)", xlabel="Q (kVAr)")
	
	# Load variation lines:
	plot!([-Q1], seriestype = :vline, 
		linestyle=:dash, linecolor=:black, label=:none)
	plot!([Q2], seriestype = :vline, 
		linestyle=:dash, linecolor=:black, label=:none)
	plot!([U2], seriestype = :hline, 
		linestyle=:dash, linecolor=:black, label=:none)

	# Voltage correction/reactive load sharing:
	plot!(-Qload⁵⁰, Uₐ₁ʼ, linewidth=2,linecolor=:red, linestyle=:dash, label="U'₁ = f(Q'₁)")
	plot!(Qload⁵⁰, Uₐ₂ʼ, 
		linewidth=2, linecolor=:blue, linestyle=:dash, label="U'₂ = f(Q'₂)")
	plot!([-Q*K3/2, K3*Q/2], seriestype = :vline, 
		linestyle=:dash, linecolor=:green, label=:none)	
end

# ╔═╡ 075c639a-57cc-4bde-8079-9a61efad740d
begin
	Q2ʼ = (-m1*Q + K1*E₀₁ - K2*E₀₂)/(-m1+(m2))
	Q2ʼ = round(Q2ʼ, digits=1)
	
	U2ʼ = U2_intʼ(Q2ʼ)
	U2ʼ = round(U2ʼ, digits=0)

	Q1ʼ = (abs(m2)*Q + abs(K2*E₀₂ - K1*E₀₁))/(m1+abs(m2))
	Q1ʼ = round(Q1ʼ, digits=1)

	U1ʼ = U1_intʼ(Q1ʼ)
	U1ʼ = round(U1ʼ, digits=0)
end;

# ╔═╡ b13cc67a-5ff9-4918-8b8e-13fb3b0e452e
md"""
 $$\quad U'=$$ $(U1ʼ) $$\rm V\quad$$ $$\quad Q=$$ $(Q) $$\rm kVAr\quad$$ $$\quad Q_1'=$$ $(Q1ʼ) $$\rm kVAr\quad$$ $$\quad Q_2'=$$ $(Q2ʼ) $$\rm kVAr\quad$$
"""

# ╔═╡ 21ab727a-d417-4728-9ceb-706789fc37b9
begin

	# synchronous condenser:
	δ₃= 0
	I⃗₃= (I₂)∠(90)
	I₃ = abs(I⃗₃)
	I⃗d₃= I⃗₃
	E⃗₃ = U⃗₂ - j*Xq*I⃗₃
	E⃗₀₃= E⃗₃ - j*(Xd-Xq)*I⃗d₃


	# d, q axis:
	plot([0+j*0, (1300*cosd(δ₃))+j*1100*sind(δ₃)], 
		label="eixo de quadratura", arrow=:head, linecolor=:black, linewidth=1)
	plot!([0+j*0, (500*cosd(δ₃+90))+j*500*sind(δ₃+90)],
		label="eixo direto", arrow=:head, linecolor=:black, linewidth=1, linestyle=:dashdot)
		
	#E⃗₀:
	plot!([0, E⃗₀₃], arrow=:open, label="E₀∠δ₂", linecolor=:lightgrey, linewidth=8)		
	
	plot!([E⃗₃, E⃗₃ - j*(Xd-Xq)*I⃗d₃], 
			arrow=:closed, label="(Xd-Xq)Id∠(δ₂)", linewidth=2)

	# I⃗d
	plot!([0, I⃗d₃],arrow=:open, label="Id∠(δ₂-90°)=I₂∠φ₂", linewidth=6, linecolor=:orange)
	
	# E⃗':
	plot!([0, E⃗₃], arrow=:closed, minorticks=5, label="E'₂∠δ₂", linewidth=2,
		  ylims=(-500,1000), xlims=(-100,1400), size=(600,600))
	
	jXqI⃗₃ = (Xq*I₃)∠(180)
	plot!([U⃗₂, U⃗₂-jXqI⃗₃], arrow=:closed, label="XqI₂∠(φ-90°)", linewidth=2)
	
	plot!([0, U⃗₂], arrow=:closed, legend=:topright, linewidth=2, label="U₂∠0°")
	plot!([0, I⃗₃], arrow=:closed, label="I₂∠φ₂", linewidth=2)

end

# ╔═╡ fe7a2fe7-40f5-412c-83f9-1e7084809cb0
begin
	Iₙ = Pᵤ/(η*√3*U▵*cosφ) 						# line current, A
	Iₙ = round(Iₙ, digits=1)
	φ = acos(cosφ)
	φ = rad2deg(φ)
	φ = round(φ, digits=1)
	I⃗ₙ = (Iₙ)∠(φ) 								# line current vector, A
	Text("I⃗ₙ = $(Iₙ)A ∠$(φ)°")
end

# ╔═╡ fd7ecd4b-a8f8-4809-9f36-505494221a70
begin
	U⃗ = (U▵)∠(0) 				# phase voltage vector (Delta connection), V
	I⃗ = I⃗ₙ/√3 					# Delta current (Delta connection), A
	I = abs(I⃗)
	I = round(I, digits=1)
	Text("U⃗ = $(U▵) V ∠$(0)°"), Text("I⃗ = $(I) A ∠$(φ)°")
end

# ╔═╡ 8592168c-5e8d-43d4-8c33-b73c836223a7
begin
	E⃗₀ʼ = U⃗ - j*Xₛ*(I⃗)
	
	E₀ʼ = abs(E⃗₀ʼ)
	E₀ʼ = round(E₀ʼ, digits=1)
	δ = angle(E⃗₀ʼ)
	δ = rad2deg(δ)
	δ = round(δ, digits=1)
	Text("E⃗₀ʼ = $(E₀ʼ)V ∠$(δ)°")
end

# ╔═╡ 32016778-0b66-4a0c-82f8-1c1f0e562d8b
begin
	E₀₁ʼ = E₀ʼ*Kc 
	E₀₁ʼ = round(E₀₁ʼ, digits=1)
end

# ╔═╡ 82941af9-9cf9-4b92-b308-ad1db029fa72
begin
	δₗ=0:0.1:180 				# valores de δ para realização dos gráficos, [°]
	δ₀=0	
	Pₘₐₓ=3*U▵*E₀₁ʼ/Xₛ 			# potência máxima para δ=90°, [W]
	δₗᵢₘ=asin(Pₗᵢₘ*1000/Pₘₐₓ)	# δ para a potência escolhida, [rad]
	δₗᵢₘ=rad2deg(δₗᵢₘ)			# δ para a potência escolhida, [°]
	δₗᵢₘ=round(δₗᵢₘ, digits=2)	
	Pd(δₗ)=Pₘₐₓ*sin(δₗ*π/180)	# função potência desenvolvida, [W]

	# Gráfico:
	plot(δₗ -> Pd(δₗ), 0, δₗᵢₘ, 
		linewidth=3, linecolor=:blue, label="P(δ)", 
		ylabel="P (W)", xlabel="δ (°)", xlims=(0,210), ylims=(0,1.2*Pₘₐₓ),
		title="Aplicação do critério da igualdade das áreas")
	
	plot!(δₗ -> Pd(δₗ), 0, δₗᵢₘ, fillrange = Pₗᵢₘ*1000,
		linewidth=3, linecolor=:blue, fillcolor=:green, label=false)
	
	plot!([Pₗᵢₘ*1000], seriestype=:hline,
		linewidth=2, linecolor=:red, label="Pₗᵢₘ=$Pₗᵢₘ W")
	
	plot!(δₗ -> Pd(δₗ), δₗᵢₘ, 180-δₗᵢₘ, fillrange = Pₗᵢₘ*1000,
		linewidth=3, linecolor=:blue, label=false, fillcolor=:grey)
	
	plot!(δₗ -> Pd(δₗ), 180-δₗᵢₘ, 180,
		linewidth=3, linecolor=:blue, label=false)
	
	plot!([δₗᵢₘ], seriestype=:vline, label="δₗᵢₘ=$δₗᵢₘ °",
		linewidth=1, linecolor=:red, linestyle=:dash) 
end

# ╔═╡ 8bf55f99-3cfb-4ffc-95d2-367fb213f3a5
begin
	Pₛₒₗ=(1/1000)Pd(δₛₒₗ)
	Pₛₒₗ=round(Pₛₒₗ, digits=2)
end;

# ╔═╡ bfd3608d-6aa2-4891-be71-cd809ce71dc6
md"""
Substituindo $$\delta_{\text{lim}}$$ na expressão da potência desenvolvida, $$P(\delta)$$, obtém a potência admissível pela máquina síncrona em regime de grandes perturbações, $$P_{\text{lim}}=$$ $Pₛₒₗ $$\rm{kW}$$, quando esta se encontra a funcionar em regime nominal.
"""

# ╔═╡ 377458d9-a00e-45af-9f4b-d8961bca5f89
begin
	δ₁ = asin((E₀ʼ/E₀₁ʼ)*sin(δ*π/180))
	δ₁ = rad2deg(δ₁)
	δ₁ = round(δ₁, digits=1)
end

# ╔═╡ 084f8cb6-dba4-452f-86cb-7a19117185ff
begin
	E⃗₀₁ʼ= (E₀₁ʼ)∠(δ₁)
	Text("E⃗₀₁ʼ = $(E₀₁ʼ)V ∠$(δ₁)°")
end

# ╔═╡ 8ff2dca1-b7fc-4597-8fb3-30d6d848c8f3
begin
	I⃗₁ = (U⃗ - E⃗₀₁ʼ)/(j*Xₛ)
	I₁ = abs(I⃗₁)
	I₁ = round(I₁, digits=1)
	φ₁ = angle(I⃗₁)
	φ₁ = rad2deg(φ₁)
	φ₁ = round(φ₁, digits=1)
	Text("I⃗₁ = $(I₁)A ∠$(φ₁)°")
end

# ╔═╡ 336eef9b-b608-43d7-b36f-d282371fecea
begin
	
	# axis: kW(δ), kVAr(δ)
	plot([0+j*0, 1000+j*0], label=false, arrow=:head,	linecolor=:black, linewidth=1)
	plot!([U▵-j*U▵, U▵+j*U▵], label=false, arrow=:head, linecolor=:black,	linewidth=1)
	annotate!(950, -40, text("\$Q(δ)\$", :black, :right, 10))
	annotate!(390, 320, text("\$P(δ)\$", :black, :right, 10))

	plot!([0+j*0, -200+j*0], label=false, arrow=:head, linecolor=:black, linewidth=1)
	plot!([0+j*U▵, 0-j*U▵], label=false, arrow=:head, linecolor=:black, linewidth=1)
	annotate!(-60, -40, text("\$P(ϕ)\$", :black, :right, 10))
	annotate!(-20, -330, text("\$Q(ϕ)\$", :black, :right, 10))
	
	Kb = 1/1.3 					# current scale factor
	jXₛI⃗ = (Xₛ*I)∠(φ+90)
	plot!([0, U⃗], arrow=:closed, linecolor=:blue, linewidth=2, legend=:topright, label="U∠0°")
	
	plot!([0, Kb*I⃗], arrow=:closed, linecolor=:red, linewidth=2, linestyle=:dash, 		label="I∠φ")
	plot!([U⃗, U⃗-jXₛI⃗], arrow=:closed, linecolor=:green, linewidth=2, linestyle=:dash,
		label="XₛI∠(φ+90°)")
	plot!([0, E⃗₀ʼ], arrow=:closed, linecolor=:magenta, linewidth=2, linestyle=:dash,
		minorticks=5, label="E'₀∠δ", ylims=(-600,600), xlims=(-200,1000), size=(600,600))

	
	plot!([0, Kb*I⃗₁], arrow=:closed, linecolor=:red, linewidth=2, label="I₁∠φ₁")
	jXₛI⃗₁ = (Xₛ*I₁)∠(φ₁+90)
	plot!([U⃗, U⃗-jXₛI⃗₁], arrow=:closed, linecolor=:green, linewidth=2, 
		label="XₛI₁∠(φ₁+90°)")
	plot!([0, E⃗₀₁ʼ], arrow=:closed, linecolor=:magenta, linewidth=2, label="E'₀₁∠δ₁")

end

# ╔═╡ dd71e95f-8b01-48e1-a8ea-c82872986536


# ╔═╡ 0039b313-a760-44c7-9252-d6cd82c76205
md"""
## _Setup_
"""

# ╔═╡ 2b0b227b-e818-4b5e-a883-0dcd5419b205
if lang == "pt"
	md"""
	Documentação das bibliotecas `Julia` utilizadas: [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools.jl](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [Roots](https://juliamath.github.io/Roots.jl/stable/), [Dierckx](https://github.com/kbarbary/Dierckx.jl).
		"""
elseif lang == "en"
	md"""
	`Julia` packages documentation: [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/), [EasyFit.jl](https://github.com/m3g/EasyFit.jl), [Roots](https://juliamath.github.io/Roots.jl/stable/), [Dierckx](https://github.com/kbarbary/Dierckx.jl).
	"""
end

# ╔═╡ 440f6f76-98bd-484c-b993-1a71cdbfe634
begin
	version=VERSION
	if lang == "pt"
		md"""
		*Notebook* desenvolvido em `Julia` versão $(version).
		"""
	elseif lang == "en"
		md"""
		Notebook developed in `Julia` version $(version).
		"""
	end
end

# ╔═╡ c4a9e3a0-3471-4c7f-ab7e-87d34aea85a7
if lang == "pt"
	md"""
	!!! info
		No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
	"""
elseif lang == "en"
	md"""
	!!! info
		In the table of contents of this notebook, topics marked with "💻" require student participation.
	"""
end

# ╔═╡ ceb57965-22b9-48e9-85ef-47e6380a613b
if lang == "pt"
	TableOfContents(title="Índice", depth=4)
elseif lang == "en"
	TableOfContents()
end

# ╔═╡ fd069020-c69e-4ba0-810c-d5dba7e6e6ea
md"""
|  |  |
|:--:|:--|
|  | This notebook, [Test.ACmachines.jl](https://ricardo-luis.github.io/me-2/Test.ACmachines.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2026 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dierckx = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Roots = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"

[compat]
Dierckx = "~0.5.4"
Plots = "~1.41.7"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.83"
Roots = "~3.0.8"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.0"
manifest_format = "2.1"
project_hash = "154f1e9abb6275cb8d06be123dfbe89f8f3fa3ad"

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

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
registries = "General"
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

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
registries = "General"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1fa950ebc3e37eccd51c6a8fe1f92f7d86263522"
registries = "General"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.7+0"

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

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

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

[[deps.Dierckx]]
deps = ["Dierckx_jll"]
git-tree-sha1 = "7da4b14cc4c3443a1afc64abee17f4fcb45ad837"
registries = "General"
uuid = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
version = "0.5.4"

[[deps.Dierckx_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3251f44b3cac6fec4cec8db45d3ab0bfed51c4d8"
registries = "General"
uuid = "cd4c43a9-7502-52ba-aa6d-59fb2a88580b"
version = "0.2.0+0"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
registries = "General"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

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

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

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

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "9d9531a9cb63a9edc33836414e82a07e81710de2"
registries = "General"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "100.14004.0+0"

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

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.6+0"

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

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1912a9f1b9ca55005b03ba075f8e19993583e237"
registries = "General"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.58.2+0"

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

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates"]
git-tree-sha1 = "8238217340ad0aaabe11afe39c1098b5bc9f4c8e"
registries = "General"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.1.1"

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

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "4f96c596b8c8258cc7d3b19797854d368f243ddc"
registries = "General"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.4"

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

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.10.1+0"

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
registries = "General"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

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

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
registries = "General"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

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
# ╟─eab2de41-f779-4705-a3cf-456c615d4fd5
# ╟─40083415-01b1-4570-bd6a-2c25e4cf4673
# ╟─4b2410af-4cb1-4e68-b745-e68625b514f6
# ╟─263cc10b-55d4-47bd-8a6c-dcdacc4cdf3d
# ╟─0262a34b-95f8-453e-812c-43663d6337b2
# ╟─5a58ddf6-b17e-4c34-bae5-2aa60245a9c3
# ╟─47a00c38-b9d7-4515-8b4b-3bca0d107e6c
# ╟─236fc3f7-321e-44f7-8ab7-18098ff1b22b
# ╟─9b6e6867-c94e-4e8e-8743-82e51f320901
# ╠═1a6abf20-e5d3-436a-bdc2-f99110ce4956
# ╠═0084d746-bb78-4575-8ae7-4fbc8e072810
# ╠═d968ea56-b785-4ec4-a3fe-51b8cf46bb0f
# ╟─cbffc42a-b2d9-4f0a-b0e6-32869e629de4
# ╟─a4aa3362-ce8c-48ba-a840-9e6e8f8718a3
# ╟─6b429d28-58a9-49d9-b0d4-e48927edb3de
# ╟─1dca324c-2a26-4da8-9e17-f10bc01a7300
# ╟─53284387-5f8b-4838-ba77-2c69c58c73eb
# ╟─c5904d62-a2ab-4298-bcb2-a398c89ef77c
# ╠═bd4783a6-936c-4700-bbf8-74b632eb8328
# ╠═b6813c43-a2b4-42f7-85c3-111f6ff48767
# ╟─3bdecd8a-708d-4bbf-811a-4f96e2f011b9
# ╟─039f5f54-872d-41ba-85a4-5c134a1a0c1b
# ╟─266ad8ad-9fca-415f-b8e6-026c4f481364
# ╟─f6d5a921-021e-4ff4-9d75-6e6add431efb
# ╟─b00d70d1-a7fd-4c7f-90fe-a8722ad50b31
# ╟─26e6b2e7-ec1e-456e-848e-57af1f0a27dd
# ╠═ff8ce092-49a1-4165-b621-246ad4335c81
# ╠═4e19252c-ab26-404f-b0da-4449fd0450b7
# ╠═e9074cf1-9a24-451e-aa64-cd948b15f9b6
# ╠═052e8a6e-dd54-4079-b112-6b5275cfd6bb
# ╠═d4defde1-3d5f-4473-b9f6-24322d92fdd8
# ╠═c0c59b61-943e-4ed0-935c-ec5cdf665b0d
# ╠═b44937d1-b83a-417b-a153-679d388adb59
# ╟─253bfa2d-233a-4320-b8df-bdffd5501c43
# ╟─48c57f54-1cb3-43af-a853-f778d5f37ad8
# ╟─06f9ce73-97b1-4323-8960-e8616d1f8af1
# ╟─0c8e08b0-2a1f-43f1-9bfa-a4a31d255ade
# ╟─9b1449bf-64d5-482c-9504-96a1638c8f62
# ╟─d21bcd53-f213-46cc-8e11-cfa336bf98aa
# ╟─a99ee5e5-334f-4125-9032-f14b070373cc
# ╟─12fb6b85-6e04-4dbc-bb04-6ff10e2da2f5
# ╟─c71d7953-dc87-4f39-bc50-e76a63a53fcf
# ╟─f1cdf6dd-e704-4eec-8a01-92ee3965d626
# ╟─75e477a5-e856-4ad6-a659-ac02e58ecf8a
# ╟─e993f8a1-5662-4f3b-b51b-8e0ef1fec76d
# ╟─5bf619b1-8756-4efd-9104-ea7bf7bcd079
# ╟─71e8be35-232f-4772-aca7-defe3cac3cd0
# ╟─14389231-1876-4015-8f1d-d7f5fa41a04c
# ╟─f164a7e0-2923-4154-802d-8128f5b06450
# ╟─72c821fe-33e9-46a9-8414-076f14b7ab3f
# ╟─974731dd-ca12-42b8-9f82-9d1337cf319c
# ╟─b13cc67a-5ff9-4918-8b8e-13fb3b0e452e
# ╟─4eac8988-f5c8-44d5-8fad-2b127d55bc3c
# ╟─dc9f5db7-38dc-4d41-a9de-b29b2ab6fb0f
# ╟─9c25ef0d-bfd4-4957-80a3-ff6a6fe9f858
# ╟─849a11aa-b172-428c-8b9a-a49879d70f80
# ╟─a3a183a1-383d-446f-9ed4-c2925398061b
# ╠═69d15fb8-85f8-4bec-a647-dc07afc8ba3c
# ╟─cddb2d07-a783-4897-a7dd-1e81cdd86df0
# ╠═661f99ef-de1c-4b53-a26d-e07e92badc52
# ╠═a752ef6e-b021-437c-9942-fa44887ee3d9
# ╠═f083fcc7-d4d6-49ba-a6cf-27417a9d2a32
# ╠═ff6964bd-9f21-42c2-8f15-c6b30330c169
# ╟─57c7d7f0-0b06-4f3f-8403-e8867b6f4fc4
# ╠═3398ead4-b619-4215-a05c-b68399c20c53
# ╠═1197f2e8-161b-4416-a8e8-621f7ebe3d6b
# ╠═1e113a09-77c3-44f2-af30-72a587396cb7
# ╠═de8110e6-3caf-4169-9af9-55783689bc8c
# ╠═2b7d5e66-78cb-43dc-884f-1df1a745764f
# ╠═075c639a-57cc-4bde-8079-9a61efad740d
# ╟─5ce13622-87c3-40ed-97a2-58591f6f9514
# ╟─55b1dd0d-8a3c-45b5-8681-7388fdcc7de5
# ╟─76db2f36-7b1c-4472-a3e6-ca1c4520b28e
# ╟─21ab727a-d417-4728-9ceb-706789fc37b9
# ╟─882151a2-8110-4829-9b4b-f6a47e9aa6be
# ╟─b8492061-7322-4af8-a885-1dbbb36f2f36
# ╟─52f3510a-0d30-4794-8ea7-c9dce2a214e0
# ╟─aac2ef1d-67b8-4cee-a5ec-b0fb6c257455
# ╟─5f5d43aa-766d-4bb8-bcf9-4cb76b34c6bc
# ╠═0f0a91cc-922e-4788-857c-156859f63f0e
# ╟─a21fe332-d5f1-4fff-90ab-95380fa29ae4
# ╟─693a2aae-fc42-43d5-8745-2b397892a7a0
# ╠═fe7a2fe7-40f5-412c-83f9-1e7084809cb0
# ╠═fd7ecd4b-a8f8-4809-9f36-505494221a70
# ╠═8592168c-5e8d-43d4-8c33-b73c836223a7
# ╟─fbb03be0-96c7-4114-9b7e-80fef92bd804
# ╟─8b14d6b5-6aac-4507-8ae8-1b2823b314fd
# ╟─a25f59a4-d20b-49d6-ac6f-53899279f9a7
# ╟─336eef9b-b608-43d7-b36f-d282371fecea
# ╠═32016778-0b66-4a0c-82f8-1c1f0e562d8b
# ╠═377458d9-a00e-45af-9f4b-d8961bca5f89
# ╠═084f8cb6-dba4-452f-86cb-7a19117185ff
# ╠═8ff2dca1-b7fc-4597-8fb3-30d6d848c8f3
# ╟─bd899d78-df7b-4770-b43a-965ab1ac11e0
# ╟─7b68f211-36b3-4577-9d9e-763b14ef95d7
# ╟─8ece1d58-d4aa-441f-ae69-d25685670472
# ╟─3718458e-0f67-42cd-a27d-317ee0906145
# ╟─82941af9-9cf9-4b92-b308-ad1db029fa72
# ╟─1dca9b65-07bf-4c52-b691-65ae0147887c
# ╟─d81ab12b-6339-477c-b69c-0981ca04d1d2
# ╟─24236092-6fa3-4c86-b70c-f4f32c15d14d
# ╟─8330caa4-d7b9-476b-92d9-38f0b64af425
# ╠═706c07f0-eebb-4f71-8a4d-3093b1c79af9
# ╟─714edc82-b6f7-4b88-b345-c9578f83ff30
# ╠═a19492ac-cc05-4f3b-9789-4f6cee8d9439
# ╟─bfd3608d-6aa2-4891-be71-cd809ce71dc6
# ╠═8bf55f99-3cfb-4ffc-95d2-367fb213f3a5
# ╟─e178a306-05a2-4fcb-8101-db1d4fd11cf4
# ╟─04c34d5b-7cb9-418a-84a5-6ec900cefa58
# ╟─d6c33c3b-3823-4091-a397-5b78212d33d4
# ╟─42f5ca5e-e0c8-46d2-937a-93929b833271
# ╟─1a5bf852-377d-4a42-9c31-b0fb0d4183ae
# ╟─53087350-c94f-41e3-a0e3-9ad6a54f1d7e
# ╠═0ca024ef-9fe9-41e6-a87e-feaddc80191f
# ╠═aecd1555-ed11-4ab0-ad3d-98ada78f45a7
# ╟─dd71e95f-8b01-48e1-a8ea-c82872986536
# ╟─0039b313-a760-44c7-9252-d6cd82c76205
# ╟─2b0b227b-e818-4b5e-a883-0dcd5419b205
# ╠═b88eb231-8e1b-4211-bb68-9f3b2b78fb10
# ╟─440f6f76-98bd-484c-b993-1a71cdbfe634
# ╟─c4a9e3a0-3471-4c7f-ab7e-87d34aea85a7
# ╠═ceb57965-22b9-48e9-85ef-47e6380a613b
# ╟─fd069020-c69e-4ba0-810c-d5dba7e6e6ea
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
