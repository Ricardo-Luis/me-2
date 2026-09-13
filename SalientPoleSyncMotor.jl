### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["lecture", "module3"]
#> title = "Motor polos salientes"
#> description = "Apresenta-se a resolução de um exercício sobre um motor síncrono 3~ de polos salientes. O estudo abrange o cálculo das reatâncias síncronas segundo os eixos direto e de quadratura, determinação da FEM induzida, análise das componentes de potência desenvolvida, e análise de cenários críticos como o funcionamento sem excitação. A análise inclui diagramas vetoriais e fornece uma compreensão abrangente do comportamento do motor síncrono de polos salientes em diferentes condições de funcionamento."
#> chapter = 2
#> section = 6
#> image = "https://github.com/Ricardo-Luis/me-2/blob/0c6034b35b632313249dd3b35fc8cae7367032db/images/card/SalientPoleSyncMotor.png?raw=true"
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

# ╔═╡ cce68c02-32d9-4d2b-bd1a-224aa9c07e1e
using PlutoUI, PlutoTeachingTools, Plots 
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
=#

# ╔═╡ cf712aee-817a-42a8-becb-40a351b6b8ed
TwoColumnWideLeft(md"`SalientPoleSyncMotor.jl`", md"`Last update: 11·09·2026`")

# ╔═╡ 03d786ee-301e-48fb-a213-b24da7b74199
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS SÍNCRONAS TRIFÁSICAS}$

$\text{EXERCÍCIO 13}$ 

$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Motor síncrono de polos salientes}}}$
---
"""

# ╔═╡ 589625e8-9b8e-4358-9186-66def36f9adc
md"""
# Dados:
"""

# ╔═╡ 17bc7f80-c13c-11eb-227f-b125d84c8b40
md"""
**Uma máquina síncrona 3~ de pólos salientes, $50\mathrm{MVA}$, $11\mathrm{kV-}$$60\mathrm{Hz}$, enrolamentos do
estator em Y, apresenta as reatâncias: $$X_d=0.8\mathrm{pu}$$ e $$X_q=0.4\mathrm {pu}$$. 
Como motor síncrono é colocado à plena carga com fator de potência $0.8$ indutivo. 
As perdas mecânicas representam são $0.15\mathrm{pu}$.  
Despreze as perdas na resistência do induzido.**
"""

# ╔═╡ 20ed504e-08d1-45b9-8494-c42170182898
(Sₙ, Uₙ, f, Xd, Xq, cosφₙ, pᵣₒₜ) = (50e6, 11e3, 60, 0.8, 0.4, 0.8, 0.15)

# ╔═╡ 14ae0471-3eaf-4e46-ad4a-79a7c2ef3632


# ╔═╡ 25f9aa0c-efa0-4c8a-bbfb-c5648bf2f8a2
md"""
# a) Determine $$X_d$$ e $$X_q$$ em Ω;
"""

# ╔═╡ 0545e797-9d40-48c4-ab96-195959331560
md"""
A utilização de *valores por unidade*, $$\mathrm {pu}$$,  apresenta diversas vantagens:
 - permite uma melhor comparação relativa entre máquinas de diferentes potências;
 - torna as grandezas adimensionais, facilitando a observação das mesmas face aos valores nominais de funcionamento;
 - simplifica a utilização do fator $$\sqrt3$$ em sistemas trifásicos.

Definindo a potência de base, $$S_b$$, e a tensão de base, $$U_b$$:

$$S_b=S_n\quad;\quad U_b=U_n$$

como: $$\quad S_b=U_bI_b\quad \Rightarrow\ \quad S_b=\dfrac{U_b^2}{Z_b}\quad \Leftrightarrow\quad Z_b=\dfrac{U_b^2}{S_b}$$

sendo $$Z_b$$ a impedância de base. Assim:

$$\begin{cases}X_d(\Omega) = X_d(\mathrm{pu}).Z_b\\X_q(\Omega) = X_q(\mathrm{pu}).Z_b \end{cases}$$
"""

# ╔═╡ 342aacbe-df8e-42b9-a7a2-8538476f2a80
begin
	Sb = Sₙ
	Ub = Uₙ
	Zb = Ub^2/Sb
	Xd_Ω = Xd*Zb
	Xq_Ω = Xq*Zb
	Xd_Ω, Xq_Ω
end

# ╔═╡ 8a9d2209-ed57-402f-a649-841dcf23b127


# ╔═╡ 65dd0a07-ff99-4887-8a86-142248705131
md"""
# b) Determine a FCEM em pu;
"""

# ╔═╡ 8b677658-96a8-40cb-b4cf-1638703dda22
md"""
A força contra-eletromotriz (FCEM) de vazio do motor síncrono de polos salientes, $$E'_0$$, vem dada pela equação vetorial:

$$\overline{E'}_0=\overline{U}-(R+jX_q)\overline{I}-j(X_d-X_q)\overline{I}_d$$

com: $$\quad\overline{E'}=\overline{U}-(R+jX_q)\overline{I}$$

A determinação do vetor FCEM efetiva, $$\overline{E'}$$, (cálculo intermédio de $$\overline{E'}_0$$) permite definir a posição espacial dos eixos direto (linha dos pólos) e de quadratura (posicão das FCEM), uma vez que se obtém o ângulo de carga, $$\delta$$.
"""

# ╔═╡ 3ec74057-fcbb-4d79-8aca-719289c2299e
md"""
O cálculo de $$\overline I_d$$ é obtido a partir da relação trigonométrica com o vetor da corrente, $$\overline I$$, observado o diagrama vetorial de tensões:

Assim, no caso concreto:  

$$\overline I_d=I\sin(|\varphi|-|\delta|)\angle (\delta-90°)$$
"""

# ╔═╡ 49053499-f759-4043-a9b8-48f42e45589a
md"""
## Diagrama vetorial de tensões do motor síncrono de polos salientes
"""

# ╔═╡ de577063-d31a-407c-b706-870fb9bfdc58


# ╔═╡ 19c628e8-60c9-46d0-9ab8-78e70b8bfa6f
md"""
# c) $$P_d^{fcem}(pu)$$; $$P_d^{rel}(pu)$$

**Determine a potências desenvolvidas (em pu) devido à FCEM de excitação e devido ao
efeito de relutância do rotor;**
"""

# ╔═╡ 2cd26842-6c40-4dc0-9979-da4685630aa1
md"""
As parcelas da potência desenvolvida em *valores por unidade* são determinadas pelas expressões:

$$\begin{align}
P_d^{\text{fcem}}(pu) &= \frac{UE'_0}{X_d}\sin \delta \\
\\
P_d^{\text{rel}}(pu) &= \frac{U^2(X_d-Xq)}{2X_dX_q}\sin(2\delta)
\end{align}$$

O que resulta:
"""

# ╔═╡ 70fd32b5-44a9-425b-9c87-62bdee2d6dc0


# ╔═╡ 6bc18d01-7285-4b7b-9769-3a7d52baae75
md"""
# d) Limite de estabilidade
**Se a corrente de excitação for reduzida a zero, a máquina continua em sincronismo?
Justifique;**
"""

# ╔═╡ 60f80e79-eeb8-4b60-801f-98caa28b4dfd
md"""
Por conseguinte, como: $$|P_d^{\text{rel}}(\text{max})|< |P_d|$$, conclui-se que o motor perderia o sincronismo nesta situação $$(\space I_{\text{exc}}=0\space\mathrm {pu})$$, passando a um funcionamento instável.
"""

# ╔═╡ 9432cc05-5632-4e58-bf15-000783ee628c


# ╔═╡ dd7d16e4-7b01-4aa0-a1ba-ecc7881900fb
md"""
# e) Funcionamento em vazio, sem $$I_{\text{exc}}$$

**e) Se a carga ao veio for retirada e a corrente de excitação reduzida a zero, determine o valor da corrente do estator (em pu) e o fator de potência. Desenhe o diagrama vetorial da máquina para esta situação.**
"""

# ╔═╡ 61609aa9-9feb-4a63-b4e9-2fd9a88f8106
md"""
Sem carga ao veio, $$\quad P_u=0\mathrm W\quad \Rightarrow \quad P_d=p_{\text{rot}}=0.15\mathrm{pu}$$.

Por outro lado, $$\quad I_{\text{exc}}=0\mathrm A\quad \Rightarrow \quad E'_0\simeq 0\mathrm V \quad \Rightarrow \quad P_d^{\text{fcem}}\simeq 0\mathrm W$$.

Por conseguinte, $$\quad P_d^{\text{rel}}=p_{\text{rot}}=0.15\mathrm{pu}\quad$$ com $$\quad P_d^{\text{rel}}$$:

$$P_d^{\text{rel}}(pu)=\frac{U^2(X_d-X_q)}{2X_dX_q}\sin(2\delta_0)$$
"""

# ╔═╡ 28da7f3c-97fd-4a80-ad21-eeb201dcc881
md"""
Do diagrama vetorial de tensões deste motor síncrono, retiram-se as seguintes relações para as componentes da corrente, $$I$$, nos eixos direto e de quadratura, em função do ângulo de carga, δ:

$$\begin{cases}I_q=\frac{U}{X_q}\sin(|\delta|) \\I_d=\frac{U}{X_d}\cos(\delta)-\frac{E'_0}{X_d}\end{cases}$$

Vetorialmente as componentes da corrente nos eixos direto e de quadratura ficam representadas por:

$$\begin{cases}\overline I_q=I_q\angle \delta\\ \overline I_d= I_d\angle (\delta-90°)\end{cases}$$

Assim, o vetor de corrente, $$\overline I$$ é obtido por:

$$\overline I=\overline I_d+\overline I_q$$
"""

# ╔═╡ 311eecf2-4bd6-44bc-8c67-a680f4fd5d33
md"""
## 💻 Diagrama vetorial de tensões 
"""

# ╔═╡ b47b956c-8880-4c22-aeea-d9a55c518b6a
md"""
Para se perceber o efeito das reduções da carga ao veio e da corrente de excitação, criou-se um segundo diagrama vetorial de tensões/correntes, mas dependente da posição de 2 cursores (*sliders*) associados à variação de cada um dos parâmetros $$(\delta$$ e $$I_{\text{exc}})$$, permitindo observar os seus efeitos sucessivos, no desenho do diagrama vetorial:
"""

# ╔═╡ 78a2ef93-5ed1-44f8-8aa9-7e7d8d80a2df
md"""
Repare-se para qualquer valor do ângulo de carga, $$\delta$$, quando a corrente de excitação se torna nula, a FCEM de vazio, $$\overline {E'}_0$$, torna-se também nula e o diagrama vetorial de tensões pode ser representado apenas pelo triângulo retângulo formado pelos vetores: $$\quad\overline U$$, $$\space\space-jX_q\overline I_q\quad$$ e $$\quad-jX_d\overline I_d$$. 

Ou seja: $$\quad\overline {E'}_0=\overline U -jX_q\overline I_q -jX_d\overline I_d\quad$$ com $$\quad\overline {E'}_0=0 \space\mathrm{pu}$$.
"""

# ╔═╡ c5cc14a5-73c6-4f10-bc3e-bd7b68eddafa
md"""
!!! nota
	Os resultados da **alínea e)** são corretamente apresentados apenas quandos os cursores se encontrem nas posições:
	 $$\quad\delta=\delta_0 \quad \mathrm e \quad I_{\text{exc}}=0 \space\mathrm {pu}$$
"""

# ╔═╡ 5f84cb7b-9779-41d7-87b1-ecd357033c04
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

# ╔═╡ 9ac8f499-9ab5-4d4f-b65e-b621ce5e74bf
md"""
# *Notebook*
"""

# ╔═╡ 8603f697-58ec-4c77-8749-4487f2053aff
md"""
## Notação complexa
"""

# ╔═╡ dc95260b-8190-407b-9981-dff1e84acd62
begin
	∠(x) = cis(deg2rad(x)) 		# polar form
	j = Base.im 				# rectangular form
end;

# ╔═╡ d5d4554e-428a-457a-8fdb-47dc977f9d01
begin
	φₙ = -acos(cosφₙ)
	φₙ = rad2deg(φₙ)
	I = 1 					# 1pu
	U = 1 					# 1pu
	I⃗ = (I)∠(φₙ)			# current vector, pu
	U⃗ = (U)∠(0)				# voltage vector, pu
	
	# E⃗ʼ determination:
	E⃗ʼ = U⃗-j*Xq*I⃗
	Eʼ = abs(E⃗ʼ)
	Eʼ = round(Eʼ, digits=3)
	δ = angle(E⃗ʼ)
	δ = rad2deg(δ)
	δ = round(δ, digits=2)
	Eʼ, δ
end;

# ╔═╡ 4dd894c8-9b9b-474d-9a98-d805328b609e
md"""
Assim, obtém-se $$\overline{E'}=$$ $Eʼ ∠ $δ ° $$\space\mathrm {pu}$$.
"""

# ╔═╡ 45b5c9d8-93ce-4b64-8c81-431dcbc6531f
begin
	Pdʳᵉˡmax = -U^2*(Xd-Xq)/(2*Xd*Xq)
	Pdʳᵉˡmax = round(Pdʳᵉˡmax, digits=2)
end;

# ╔═╡ 892b1d19-c88a-4add-ac18-70e799e01092
begin
	δ₀ = -0.5*asin(pᵣₒₜ*2*Xd*Xq/(U^2*(Xd-Xq)))
	δ₀ = rad2deg(δ₀)
	δ₀ = round(δ₀, digits=2)
end;

# ╔═╡ 33d13e0f-80c5-478c-99e5-e9de64a8d39a
md"""
De onde resulta o valor de $$\delta_0=$$ $δ₀ °.
"""

# ╔═╡ 1ea9ab83-10c8-4d5f-8489-e9a4754e7b1b
md"""
 $$\delta \to \delta_0 \:(°)$$ $(@bind δ₂ PlutoUI.Slider(δ:0.01:δ₀, default=δ,show_value=true)) 
 $$\quad\quad\quad\quad I_{\text{exc}} \: (\rm pu)$$ $(@bind K₂ PlutoUI.Slider(0:0.1:1, default=1, show_value=true))
"""

# ╔═╡ 67b54cd9-af1a-4bb7-9a44-c66179adfbcb
begin
	φ₁ = abs(φₙ*π/180)
	δ₁ = abs(δ*π/180)
	I⃗d = (I*sin(φ₁-δ₁))∠(δ-90)
	I⃗q = (I*cos(φ₁-δ₁))∠(δ)
	Id = abs(I⃗d)
	Id = round(Id, digits=3)
	Id, δ-90
end;

# ╔═╡ a2aac898-7c8a-42c6-a7ef-a3ff736d1ab6
md"""
O que permite obter: $$\quad \overline I_d=$$ $Id ∠ $(δ-90)° $$\space\mathrm {pu}$$.
"""

# ╔═╡ cde832b5-50ea-44d8-ae4e-f1907d7e31dc
begin
	E⃗ʼ₀ = E⃗ʼ-j*(Xd-Xq)*I⃗d
	Eʼ₀ = abs(E⃗ʼ₀)
	Eʼ₀ = round(Eʼ₀, digits=3)
end;

# ╔═╡ 33a4d731-3f65-460d-a74e-609250fa6292
md"""
O vector da FCEM de vazio, $$\overline{E'}_0$$, vem então dado por:

$$\overline{E'}_0=\overline{E'}-j(X_d-X_q)\overline{I}_d$$


Assim, obtém-se: $$\quad\overline{E'}_0=$$ $Eʼ₀ ∠ $δ ° $$\space\mathrm {pu}$$.
"""

# ╔═╡ 73b14af8-f204-4070-bab9-180b660a9029
begin
	# Developed power due to back-EMF, pu:
	Pdᶠᵉᵐₚᵤ = (U*Eʼ₀ / Xd) * sin(δ*π/180)
	Pdᶠᵉᵐₚᵤ = round(Pdᶠᵉᵐₚᵤ, digits=2)
	
	# Developed power due to reluctance effect, pu:
	Pdʳᵉˡₚᵤ = (U^2 * (Xd-Xq) / (2*Xd*Xq)) * sin(2*δ*π/180)
	Pdʳᵉˡₚᵤ = round(Pdʳᵉˡₚᵤ, digits=2)
	
	# Results
	Pdᶠᵉᵐₚᵤ, Pdʳᵉˡₚᵤ  					
end

# ╔═╡ a97592ef-28ef-4d83-b979-9e5550045cd0
Pdₚᵤ = Pdᶠᵉᵐₚᵤ + Pdʳᵉˡₚᵤ  ;

# ╔═╡ 2635c31e-8a91-45b0-8e4a-b4b6f6e59ae0
md"""
Com: $$\quad I_{\text{exc}}=0\space\mathrm {pu}\quad\Rightarrow\quad E'_0\simeq 0\space\mathrm {pu}\quad \Rightarrow\quad P_d^{\text{fcem}}\simeq 0\space\mathrm {pu}$$

Por outro lado, o ponto de funcionamento, $$P_d(\delta)$$, em regime nominal é dado por: $$P_d=P_d^{\text{fcem}}+P_d^{\text{rel}}=$$ ( $Pdᶠᵉᵐₚᵤ ) + ( $Pdʳᵉˡₚᵤ ) = $Pdₚᵤ pu.  
"""

# ╔═╡ f736b324-d6d9-4d8f-93d0-d520b79d4002
md"""
Assim, sem corrente de excitação, a potência desenvolvida devido ao efeito de relutância, $$P_d^{\text{rel}}$$, tem de suprir os $Pdₚᵤ pu, do ponto funcionamento.

O valor máximo da potência desenvolvida devido ao efeito de relutância, $$P_d^{\text{rel}}(\text{max})$$, verifica-se para $$\delta=-45°$$, que permite obter:
$$P_d^{\text{rel}}(\text{max})=\dfrac{U^2(X_d-Xq)}{2X_dX_q}=$$ $Pdʳᵉˡmax pu
"""

# ╔═╡ c79f1fef-c2f1-45b0-af35-f3e69e6ec77e
begin
	# d, q axis:
	plot([0+j*0, (1.3*cos(δ*π/180))+j*1.3*sin(δ*π/180)], 
		label="eixo de quadratura", arrow=:head, linecolor=:black, 
		linestyle=:dashdot,	linewidth=2)
	
	plot!([0+j*0, (0.5*cos(δ*π/180+π/2))+j*0.5*sin(δ*π/180+π/2)],
		label="eixo direto", arrow=:head, linecolor=:black, linewidth=2)
	
	# E⃗':
	K = 0.5 	# current scale factor
	
	plot!([0, U⃗], arrow=:closed, legend=:topright, label="U∠0°", linewidth=2)
	
	plot!([0, K*I⃗], arrow=:closed, label="I∠φ", linewidth=2)
	
	plot!([U⃗, U⃗ - j*Xq*I⃗], arrow=:closed, label="XqI∠-90°", linewidth=2)
	
	plot!([0, E⃗ʼ], 
			arrow=:closed, minorticks=5, label="E'∠δ",linewidth=2, linecolor=:blue, ylims=(-0.75,0.75), xlims=(-0.25,1.25), size=(600,600))
	
	# I⃗d, I⃗q:
	plot!([0, K*I⃗d],arrow=:closed, label="Id∠(δ-90°)")
	plot!([0, K*I⃗q],arrow=:closed, label="Iq∠(δ)")
	
	#E⃗´₀:
	plot!([U⃗ - j*Xq*I⃗, U⃗ - j*Xq*I⃗ - j*(Xd-Xq)*I⃗d], 
			arrow=:closed, label="(Xd-Xq)Id∠(δ)", linewidth=2)
	
	plot!([0, E⃗ʼ₀], arrow=:closed, label="E'₀∠δ", linewidth=3)		  
end

# ╔═╡ 5861683f-db8a-4d43-9822-f2f47431c191
begin
	# I⃗q:
	Iq₂ = (U/Xq)*sin(abs(δ₂*π/180))
	I⃗q₂ = (Iq₂)∠(δ₂)
	# I⃗d:
	Eʼ₀₂ = Eʼ₀*K₂ 			# K₂: slider parameter of: "Iₑₓ (pu)" 
	Id₂ = (U/Xd)*cos(δ₂*π/180)-Eʼ₀₂/Xd
	I⃗d₂ = (Id₂)∠(δ₂-90)
	# I⃗, cosφ:
	I⃗₂ = I⃗d₂ + I⃗q₂
	I₂ = abs(I⃗₂)
	I₂ = round(I₂, digits=2)
	φ₂ = angle(I⃗₂)
	fdp = cos(φ₂)			# power factor (under-excited motor -> inductive)
	φ₂ = rad2deg(φ₂)
	fdp = round(fdp, digits=3)
	I₂, fdp, δ₂, Eʼ₀₂ 		# RESULTS
end

# ╔═╡ 9e141f07-ad66-41f4-a53b-b6c25e4afbb2
begin
	# d, q axis:
	plot([0+j*0, (1.2*cos(δ₂*π/180))+j*1.2*sin(δ₂*π/180)], 
			label="eixo de quadratura", arrow=:head, linecolor=:black, linestyle=:dashdot,	linewidth=2)
	
	plot!([0+j*0, (0.35*cos(δ₂*π/180+π/2))+j*0.35*sin(δ₂*π/180+π/2)],
			label="eixo direto", arrow=:head, linecolor=:black, linewidth=2, 
			ylims=(-0.75,0.75), xlims=(-0.25,1.25), size=(600,600))
	
	# E⃗ʼ:
	plot!([0, U⃗], arrow=:closed, legend=:topright, label="U∠0°", linewidth=2)
	plot!([0, K*I⃗₂], arrow=:closed, label="I∠φ", linewidth=2)
	plot!([U⃗, U⃗ - j*Xq*I⃗₂], arrow=:closed, label="XqI∠-90°", linewidth=2)
	
	E⃗ʼ₂ = U⃗ - j*Xq*I⃗₂
	
	plot!([0, E⃗ʼ₂], arrow=:closed, minorticks=5, label="E'∠δ", linewidth=2)
	
	# I⃗d, I⃗q:
	plot!([0, K*I⃗d₂],arrow=:closed, label="Id∠(δ-90°)", linewidth=1)
	plot!([0, K*I⃗q₂],arrow=:closed, label="Iq∠(δ)", linewidth=1)
	
	#E⃗´₀:
	E⃗ʼ₀₂ = E⃗ʼ₂ - j*(Xd-Xq)*I⃗d₂
	
	plot!([U⃗ - j*Xq*I⃗₂, U⃗ - j*Xq*I⃗₂ - j*(Xd-Xq)*I⃗d₂], 
			arrow=:closed, label="(Xd-Xq)Id∠(δ)", linewidth=2)
	plot!([0, E⃗ʼ₀₂], arrow=:closed, label="E'₀∠δ", linewidth=3)
	
	#-jXqI⃗q e -jXdI⃗d
	plot!([U⃗, U⃗ - j*Xq*I⃗q₂],arrow=:closed, label="XqIq∠(δ-90°)",linewidth=3)
	plot!([U⃗ - j*Xq*I⃗q₂, U⃗ - j*Xq*I⃗q₂ - j*Xd*I⃗d₂],
			arrow=:closed, label="XdId∠(δ-180°)", linewidth=3) 
end

# ╔═╡ a6ef52e3-bcf8-4911-aed8-b5e456f503ee
md"""
## _Setup_
"""

# ╔═╡ 1f8c1679-a4d7-48b8-866d-114467cde6f8
md"""
Documentação das bibliotecas `Julia` utilizadas: [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools.jl](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html).
"""

# ╔═╡ 2ca895f1-fbfc-4a1e-b82f-a84ea4ee37e3
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ e66c3929-1001-4cae-8e09-90e46195e7a6
md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""

# ╔═╡ 0b8866de-44be-4da4-a7c5-56fc64c895d4
TableOfContents(title="Índice")

# ╔═╡ 931ada9f-0540-4ec9-a7b6-996581e593f4
md"""
|  |  |
|:--:|:--|
|  | This notebook, [SalientPoleSyncMotor.jl](https://ricardo-luis.github.io/me-2/SalientPoleSyncMotor.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2026 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.41.7"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.83"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.0"
manifest_format = "2.1"
project_hash = "117d659571d66e82f2e1daf410ffbcd8835abcf6"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "e71ee7b4aa06b045259a7d6101e1cb45ad140bce"
registries = "General"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.1"

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

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.5.5+2"

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
# ╟─cf712aee-817a-42a8-becb-40a351b6b8ed
# ╟─03d786ee-301e-48fb-a213-b24da7b74199
# ╟─589625e8-9b8e-4358-9186-66def36f9adc
# ╟─17bc7f80-c13c-11eb-227f-b125d84c8b40
# ╠═20ed504e-08d1-45b9-8494-c42170182898
# ╟─14ae0471-3eaf-4e46-ad4a-79a7c2ef3632
# ╟─25f9aa0c-efa0-4c8a-bbfb-c5648bf2f8a2
# ╟─0545e797-9d40-48c4-ab96-195959331560
# ╠═342aacbe-df8e-42b9-a7a2-8538476f2a80
# ╟─8a9d2209-ed57-402f-a649-841dcf23b127
# ╟─65dd0a07-ff99-4887-8a86-142248705131
# ╟─8b677658-96a8-40cb-b4cf-1638703dda22
# ╟─4dd894c8-9b9b-474d-9a98-d805328b609e
# ╠═d5d4554e-428a-457a-8fdb-47dc977f9d01
# ╟─3ec74057-fcbb-4d79-8aca-719289c2299e
# ╟─a2aac898-7c8a-42c6-a7ef-a3ff736d1ab6
# ╠═67b54cd9-af1a-4bb7-9a44-c66179adfbcb
# ╟─33a4d731-3f65-460d-a74e-609250fa6292
# ╠═cde832b5-50ea-44d8-ae4e-f1907d7e31dc
# ╟─49053499-f759-4043-a9b8-48f42e45589a
# ╠═c79f1fef-c2f1-45b0-af35-f3e69e6ec77e
# ╟─de577063-d31a-407c-b706-870fb9bfdc58
# ╟─19c628e8-60c9-46d0-9ab8-78e70b8bfa6f
# ╟─2cd26842-6c40-4dc0-9979-da4685630aa1
# ╠═73b14af8-f204-4070-bab9-180b660a9029
# ╟─70fd32b5-44a9-425b-9c87-62bdee2d6dc0
# ╟─6bc18d01-7285-4b7b-9769-3a7d52baae75
# ╟─2635c31e-8a91-45b0-8e4a-b4b6f6e59ae0
# ╠═a97592ef-28ef-4d83-b979-9e5550045cd0
# ╟─f736b324-d6d9-4d8f-93d0-d520b79d4002
# ╠═45b5c9d8-93ce-4b64-8c81-431dcbc6531f
# ╟─60f80e79-eeb8-4b60-801f-98caa28b4dfd
# ╟─9432cc05-5632-4e58-bf15-000783ee628c
# ╟─dd7d16e4-7b01-4aa0-a1ba-ecc7881900fb
# ╟─61609aa9-9feb-4a63-b4e9-2fd9a88f8106
# ╟─33d13e0f-80c5-478c-99e5-e9de64a8d39a
# ╠═892b1d19-c88a-4add-ac18-70e799e01092
# ╟─28da7f3c-97fd-4a80-ad21-eeb201dcc881
# ╠═5861683f-db8a-4d43-9822-f2f47431c191
# ╟─311eecf2-4bd6-44bc-8c67-a680f4fd5d33
# ╟─b47b956c-8880-4c22-aeea-d9a55c518b6a
# ╟─1ea9ab83-10c8-4d5f-8489-e9a4754e7b1b
# ╠═9e141f07-ad66-41f4-a53b-b6c25e4afbb2
# ╟─78a2ef93-5ed1-44f8-8aa9-7e7d8d80a2df
# ╟─c5cc14a5-73c6-4f10-bc3e-bd7b68eddafa
# ╟─5f84cb7b-9779-41d7-87b1-ecd357033c04
# ╟─9ac8f499-9ab5-4d4f-b65e-b621ce5e74bf
# ╟─8603f697-58ec-4c77-8749-4487f2053aff
# ╠═dc95260b-8190-407b-9981-dff1e84acd62
# ╟─a6ef52e3-bcf8-4911-aed8-b5e456f503ee
# ╟─1f8c1679-a4d7-48b8-866d-114467cde6f8
# ╠═cce68c02-32d9-4d2b-bd1a-224aa9c07e1e
# ╟─2ca895f1-fbfc-4a1e-b82f-a84ea4ee37e3
# ╟─e66c3929-1001-4cae-8e09-90e46195e7a6
# ╠═0b8866de-44be-4da4-a7c5-56fc64c895d4
# ╟─931ada9f-0540-4ec9-a7b6-996581e593f4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
