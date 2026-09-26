### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["lecture", "module3"]
#> title = "Alternador em regime isolado"
#> description = "O exercício proposto incide sobre a análise da operação do alternador síncrono 3~ de rotor cilíndrico em rede isolada. São exploradas a determinação da característica externa com diferentes tipos de carga (resistiva, indutiva e capacitiva), a análise dos diagramas vetoriais de tensão para diferentes fatores de potência e a construção da característica de regulação necessária para manter a tensão de saída constante. A resolução considera parâmetros como a frequência e a corrente de excitação constantes, permitindo compreender o comportamento do alternador num sistema elétrico autónomo."
#> chapter = 2
#> section = 1
#> image = "https://github.com/Ricardo-Luis/me-2/blob/8260c686a90bd229c7e21f52226a802d495dfe80/images/card/StandAloneSynGen.png?raw=true"
#> layout = "layout.jlhtml"
#> date = "2026-09-11"
#> order = 1
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

# ╔═╡ 18c20096-84c1-4ec0-bb6d-185338676ced
using PlutoUI, PlutoTeachingTools, Plots, Dierckx 						
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - Dierckx.jl, tool for data interpolation
=# 

# ╔═╡ aeeef650-bea8-44d4-89d5-fbf01f94ba60
TwoColumnWideLeft(md"`StandAloneSynGen.jl`", md"`Last update: 11·09·2026`")

# ╔═╡ 55e44178-ff2c-4467-b8b5-afa0d360cdcf
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS SÍNCRONAS TRIFÁSICAS}$

$\text{EXERCÍCIO 1}$ 

$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Alternador síncrono de polos lisos: análise em regime isolado}}}$
---
"""

# ╔═╡ 89db506b-737e-4916-a495-df388314d268
md"""
# Exercício 1. Dados:
"""

# ╔═╡ 520962f0-6513-4615-ba08-a973b851ec8f
md"""
**Um alternador síncrono trifásico, $390$ kVA, $1250$ V, $50$ Hz, $750$ rpm, ligado em triângulo, apresenta os seguintes resultados dos ensaios em vazio e curto-circuito:**
"""

# ╔═╡ 99485bd5-46b8-425b-8974-6056c903b062
begin
	Iₑₓ = [0, 11.5, 15.0, 20.0, 23.5, 29.0, 33.5]
	fem = [91, 1010, 1235, 1460, 1560, 1640, 1660]
	Icc = [12, 144, 185, 242, 284, 347, 400]
	Iₑₓ, fem, Icc
end

# ╔═╡ 8da1cb6d-5f5a-49b1-9ab8-9a00d229b519
(Sₙ, Uₙ, f, n, RΩ) = (390e3, 1250, 50, 750, 0.144)

# ╔═╡ 82ddc4f5-e411-48da-abab-cc2029ee02f0
md"""
**A resistência medida aos bornes do enrolamento do induzido é $0.144$ Ω. Determine:**
"""

# ╔═╡ f52ee282-219a-4e7d-b1b6-faa4eff673f2


# ╔═╡ db6deedc-de66-43e6-955c-b4a949cd659f
md"""
(**Fonte:** exercício modificado do problema 9 de [^Malea2004])
"""

# ╔═╡ f3c0c91a-6728-4178-a7cd-02527d7df872


# ╔═╡ 0a44521c-58b4-47d3-968c-d345799e42bb
md"""
# a) $$R_s$$ 
**A resistência por fase do enrolamento induzido do alternador síncrono, considerando um coeficiente de correção do efeito pelicular da corrente de $1.2\space$;**
"""

# ╔═╡ b90f442f-41aa-485b-b0f0-170e282c028c
md"""
A resistência medida aos bornes corresponde à resistência entre fases, por conseguinte, estando o estator em triângulo tém-se:

$R_\Omega=\frac{2R \times R}{2R+R} \quad\Leftrightarrow\quad R=\frac{3}{2}R_\Omega \quad(\Omega\ \\/\textrm{por fase})$
"""

# ╔═╡ 46318b60-7480-44f8-94bc-10f69a425d54
begin
	R = 3*RΩ/2
	R = round(R, digits=3)
end

# ╔═╡ 90712d40-b1a5-445e-a1da-af62ecab7e59
md"""
O efeito pelicular da corrente, faz aumentar a resistência do condutor, pois em corrente alternada, esta tende a fluir para a periferia dos condutores, quanto maior for a frequência angular elétrica. A resistência do estator, $$R_s$$ vem então dada por:
"""

# ╔═╡ 638d41c0-4a34-4a30-9928-ba88507334af
begin
	Rₛ = R*1.2
	Rₛ = round(Rₛ, digits=3)
end

# ╔═╡ 9649494f-8378-459f-b079-d0566f2af8fb


# ╔═╡ b9f959bf-abc2-4cc8-9f1d-584bb4728e89
md"""
# b) Cálculo da tensão para um ponto de funcionamento
**A tensão de linha, para a corrente nominal e uma corrente de excitação de $33.5$ A,
considerando um fator de potência da carga de $0.9$ indutivo;**
"""

# ╔═╡ 59f534f3-da67-406c-ae7f-9f3ddf13d1fe
md"""
Cálculo da corrente nonimal na linha, $I_{nl}$:

$I_{nl}=\frac{S_n}{\sqrt{3}\space U_n}$

A corrente nominal por fase, $I_n$, estando o estator com os enrolamentos em triângulo, vem:

$I_n=\frac{I_{nl}}{\sqrt{3}}$
"""

# ╔═╡ 3570ce87-a57d-4abb-8477-f33957697952
begin
	Iₗ = Sₙ / (√3*Uₙ) 				# line current, A
	Iₙ = Iₗ / (√3)	  				# phase current (Delta connection), A
	Iₙ = round(Iₙ, digits=1)
end

# ╔═╡ 94c43668-0ddd-4550-9bca-5b05a1ede581
md"""
O ensaio de curto-circuito permite determinar a impedância equivalente da máquina. Assim, para uma corrente de excitação de 33.5A têm-se uma corrente de curto-circuito de 400A e uma força eletromotriz (FEM) correspondente de 1660V.

"""

# ╔═╡ 5d555c37-3ea9-4315-b31f-c5ce86896160
begin
	Icc₁ = 400
	E₀ = 1660
	Zₛ = E₀ / (Icc₁/√3)
	Zₛ = round(Zₛ, digits=3)
end;

# ╔═╡ 5e679cb2-dd7f-4cf5-8035-54ae205eba1e
md"""
Assim, partindo do esquema equivalente do alternador síncrono de pólos lisos com estator em triângulo, a impedância síncrona, $$Z_s$$, vem dada por:

$Z_s=\frac{E_0}{\dfrac{I_{cc}}{\sqrt{3}}}$

 $$Z_s=$$ $Zₛ Ω:
"""

# ╔═╡ 67329e1c-c84a-4a64-abdf-d086b59cee6d
begin
	Xₛ = √(Zₛ^2-Rₛ^2)
	Xₛ = round(Xₛ, digits=3)
end;

# ╔═╡ 69998624-54dc-49a6-9053-0322c72982ea
md"""
Pelo triângulo de impedâncias obtém-se a reatância síncrona, ou seja:

$X_s=\sqrt{Z_s^2-R_s^2}$

 $$X_s=$$ $Xₛ Ω:
"""

# ╔═╡ 32294557-b288-4cff-9d2e-60e9dc3eeb1c


# ╔═╡ a2c4ba4e-56fa-4aaa-ba4a-5b5acb3cb2d8
md"""
Cálculos auxiliares:
"""

# ╔═╡ ccec9d74-f4aa-4254-89a1-f99e2e1cf653
begin
	cosφ = 0.9 				# considered inductive power factor
	φ = -acos(cosφ)
	θ = atan(Xₛ/Rₛ)
end;

# ╔═╡ 7df06422-db2c-4494-97c1-6ed2a1bc77eb
md"""
O cálculo da tensão, $$U$$, corresponde à resolução da equação vetorial por fase:
"""

# ╔═╡ 87bf1d67-5f81-496e-a6ee-821b3f3eb1b0
md"""
$$\overline{E}_0=\overline{U}+(R_s+jX_s)\overline{I}$$

em que: $$\quad R_s+jX_s=Z_s∠\theta\:$$, sendo: $$\quad Z_s=\sqrt{R_s^{2}+X_s^{2}}\quad$$ e $$\quad \theta=\arctan \frac{X_s}{R_s}$$
"""

# ╔═╡ 2385f6d9-1770-4fee-a7ab-3322f2d6e9ed
begin
	sinδ = (Zₛ/E₀) * Iₙ * sin(θ+φ)
	δ = asin(sinδ)
	U = E₀ * cos(δ) - Zₛ*Iₙ*cos(θ+φ)
	U = round(U, digits=1)
	δ = rad2deg(δ)					#δ: load angle, degrees
	δ = round(δ, digits=2)
	U, δ 
end

# ╔═╡ ce99f675-29ac-4413-94a9-febe1243e79d
md"""
Assim, a equação vetorial de $$\overline{E}_0$$ vem dada por:

$$E_0∠\delta=U∠0°+(Z_s∠\theta)(I∠\varphi)$$

Na equação vetorial acima desconhecem-se o ângulo de carga, $$\delta$$, e a tensão, $$U$$.\
Decompondo a equação vetorial nas suas coordenadas ortogonais (projeções dos vetores nos eixos real e imaginário), tém-se:

$$\begin{cases}
E_0\cos\delta=U+Z_sI\cos(\theta+\varphi)\\
E_0\sin\delta=Z_sI\sin(\theta+\varphi)\\
\end{cases}$$

Resolvendo, obtêm-se: $$\delta=$$ $δ ° e $$U=$$ $U V.
"""

# ╔═╡ e3a3c2f7-43f5-40ab-8693-9affc1130373


# ╔═╡ ff08e1d0-6acd-4b46-ab75-51329cb00c22
md"""
## Diagrama vetorial de tensões
"""

# ╔═╡ 57790c82-9d40-4244-8b5d-3fcf98ce12e7
md"""
Complementarmente, uma vez determinados os fasores da equação vetorial de $$\overline{E}_0$$ procede-se à representação do diagrama vetorial de tensões no plano complexo:
"""

# ╔═╡ e934fad8-c4fe-4e7f-bc64-e1c3f3e52460
aside(md"""
!!! nota
	O estudante deverá procurar perceber as implicações no valor da tensão de saída, $$U$$, de um alternador em regime isolado, quando o valor de corrente, $$I$$, é alterado e/ou o seu fator de potência, $$\cos \varphi$$.
""", v_offset=100)

# ╔═╡ 96d3e48e-60bc-4c97-aac4-6517502fa936
md"""
## 💻 Efeito da corrente de carga e do fator de potência
"""

# ╔═╡ f68a29b1-64c3-466b-987b-0c66b8385af3
md"""
 $$I(\rm A):$$ $(@bind I₂ PlutoUI.Slider(0:1:1.4*Iₙ, default=Iₙ,show_value=true))
$$\quad\quad\quad \varphi(°) \to \cos \varphi$$ $(@bind phi₂ PlutoUI.Slider(-90:1:90, default=-30, show_value=true))
"""

# ╔═╡ d3581eff-e1c7-4e01-b722-3d94ff428746


# ╔═╡ 14df28f1-6cb0-4e18-b5f0-4c8f94d02a56
md"""
## Determinação de $$X_s$$ para diversos valores de $$I_{exc}$$
"""

# ╔═╡ 76b147a2-d33f-49ef-8236-444818042a12
md"""
O mesmo exercício poderia ser repetido para diferentes valores da corrente de campo. Note-se que a impedância e por conseguinte, a reatância síncrona da máquina variam em função do estado de magnetização da máquina.  

Aqui mostra-se o exemplo de cáculo da reatância síncrona, $$X_s$$, para variações sucessivas de $$2$$ A na corrente de campo:
"""

# ╔═╡ f50dc850-e32d-4fb3-afd2-0217cf8df1fc
# computational method of querying the E₀(Iₑₓ) curve, by interpolating the data using Pkg Dierckx.jl:
E₀_i = Spline1D(Iₑₓ, fem);

# ╔═╡ 2dd82e2e-675f-40dd-882f-fe90db117589
# computational method of querying the Icc(Iₑₓ) curve, by interpolating the data using Pkg Dierckx.jl:
Icc_i = Spline1D(Iₑₓ, Icc);

# ╔═╡ b350ee3d-7705-4712-a9bd-d16d4a83f89b
begin
	iₑₓ = 0:2:33.5
	E₀_iₑₓ₁ = E₀_i(iₑₓ)			# data interpolation in magnetic characteristic
	Icc_iₑₓ₁ = Icc_i(iₑₓ)     	# data interpolation in short-circuit characteristic
	
	# Cálulo de Xs=f(Iex):
	Zₛ_iₑₓ₁ = E₀_iₑₓ₁./(Icc_iₑₓ₁/√3)
	Xₛ_iₑₓ₁ = .√(Zₛ_iₑₓ₁.^2 .-Rₛ^2)
	Xₛ_iₑₓ₁ = round.(Xₛ_iₑₓ₁, digits=3)
	
	# Representação gráfica de Xs:
	plot(iₑₓ, Xₛ_iₑₓ₁, xlims=(0,35),
		title="Xₛ=f(Iₑₓ)", xlabel = "Iₑₓ (A)", ylabel="Xₛ (Ω)", label=:none)
end

# ╔═╡ cd338db8-8a5b-4ebf-a93d-95b1a7433de7


# ╔═╡ ba2a8447-a8a0-4ce8-9d53-03a0369703c6
md"""
# c) Características externas
**A característica exterior do alternador síncrono trifásico, com uma corrente de excitação de $33.5$ A, para um fator de potência $0.9$ indutivo, unitário e $0.9$ capacitivo;**
"""

# ╔═╡ 8a1756c9-6d37-4541-ba8d-586e95b4feda
md"""
Para uma corrente de excitação de 33.5A, a FEM apresenta o valor de 1660V, como verificado na alínea anterior. 
"""

# ╔═╡ 9238a818-157c-4523-b6b2-139faf8ebe44
md"""
A determinação da característica externa deste alternador de polos lisos, $$U=f(I)$$ com corrente de campo e velocidade constantes,  corresponde à resolução da equação vetorial de $$\overline{E}_0$$ fazendo variar a corrente de carga, $$I$$, para um determinado fator de potência, $$\cos\varphi$$, imposto pela carga. 
"""

# ╔═╡ 58011f3c-364f-42b7-a9de-17fe736f80d1
md"""
Determinação da característica externa para $$\cos\varphi=0,9(i)$$:
"""

# ╔═╡ 894c1642-9272-4624-b7a3-c8a882fbc337
begin
	I₃ = 0:1:1.5*Iₙ
	cosφ₃ = 0.9
	φ₃ = -acos(cosφ₃)
	δ₃ = asin.((Zₛ/E₀).*I₃*sin(θ+φ₃))  		# δ: load angle, radians
	U₃ = E₀*cos.(δ₃) - Zₛ.*I₃*cos(θ+φ₃)	 	# calculation of load characteristic
end;

# ╔═╡ 079234a4-3aa6-4932-8a25-2a8c8f290368
md"""
Determinação da característica externa para $$\cos\varphi=1$$:
"""

# ╔═╡ 373a9233-e5d1-4c18-a1aa-162f3a1a00be
begin
	δ₄ = asin.((Zₛ/E₀).*I₃*sin(θ+0))  		# δ: load angle, radians
	U₄ = E₀*cos.(δ₃) - Zₛ.*I₃*cos(θ+0) 		# calculation of load characteristic
end;

# ╔═╡ b2a13c34-84be-4c7d-bcd8-9186a4975559
md"""
Determinação da característica externa para $$\cos\varphi=0,9(c)$$:
"""

# ╔═╡ fee556d9-aa55-4187-b83c-afa2173e2adb
begin
	cosφ₅ = 0.9
	φ₅ = acos(cosφ₅)
	δ₅ = asin.((Zₛ/E₀).*I₃*sin(θ+φ₅))  		# δ: load angle, radians
	U₅ = E₀*cos.(δ₃) - Zₛ.*I₃*cos(θ+φ₅)	 	# calculation of load characteristic
end;

# ╔═╡ 1daacb53-b03f-476d-9ab0-c1dc59356147
begin
	plot(I₃, U₃, 
		title="U =f(I)", xlabel="I(A)", ylabel="U(V)", label="cosφ=0.9(i)",
		ylims=(0,2000), framestyle=:origin, minorticks=5, legend=:bottomleft)
	plot!(I₃, U₄, label="cosφ=1")
	plot!(I₃, U₅, label="cosφ=0.9(c)")
end

# ╔═╡ 889e92f2-9104-4206-8e2e-785fc750a2c2


# ╔═╡ 33bd0f07-6c4c-4e1b-bad1-719871b4e56e
md"""
## 💻 Caract. de regulação, $$I_{exc}=f(I)$$, para um dado $$\cos\varphi$$
"""

# ╔═╡ 1e30acf6-44bd-4caa-a461-ec358da607ea
md"""
A análise dos efeitos da corrente de carga e do fator de potência, quer no diagrama vetorial de tensões do alternador síncrono de pólos lisos, quer nas características externas para diferentes $$\cos\varphi$$, permite antever a necessidade de se regular a corrente de campo, $$I_{exc}$$, regulando o fluxo magnético, e por conseguinte, a FEM, $$E_0$$, de modo a manter a tensão de saída do alternador síncrono, $$U$$, constante para qualquer carga.
"""

# ╔═╡ 1dc1c2e2-11e6-4d30-ac49-4797117a5dae
md"""
Tome-se, por exemplo, a corrente de campo em vazio de $$20$$ A:
"""

# ╔═╡ 81223b60-4ca2-445e-9ce6-23261cd0e525
begin
	Iₑₓ₀ = 20
	U₀ = E₀_i(Iₑₓ₀)				# data interpolation in magnetic characteristic
	Icc_iₑₓ₀ = Icc_i(Iₑₓ₀) 		# # data interpolation in short-circuitcharacteristic
	Zₛ₀ = U₀ / (Icc_iₑₓ₀/√3) 	# calculation of Zₛ as a function of field current
	Xₛ₀ = √(Zₛ₀^2-Rₛ^2)	  		# calculation of Xₛ as a function of field current
	θ₀ = atan(Xₛ₀/Rₛ)
	Iₑₓ₀, U₀, Icc_iₑₓ₀, Xₛ₀   
end

# ╔═╡ 8436976e-60cb-4904-aeb3-c9c65562a7a6
md"""
A resolução da equação vetorial de $$\overline{E}_0$$, dada por:

$$\overline{E}_0=\overline{U}+(R_s+jX_s)\overline{I}$$

permite determinar o valor da FEM, $$E_0$$, e por consulta da característica magnética, obter a corrente de campo necessária para manter a tensão, $$U$$, constante em função da carga, $$I$$, e do fator de potência, $$\cos\varphi$$. 

Note-se, que o cálculo exato desta equação vetorial apenas é possível recorrendo a métodos de cálculo númerico iterativos (método de Euler, Runge–Kutta, entre outros), pois a reatância síncrona, $$X_s$$, depende da solução final (corrente de campo).

Por simplificação na análise, admite-se que os efeitos da variação, quer da corrente de carga, quer do fator de potência, são mais significativos que a dependência $$X_s=f(I_{exc})$$, permitindo assim um cálculo aproximado, apresentado no gráfico de característica de regulação:
"""

# ╔═╡ 95aedd7b-68fd-49fc-aa2d-ef5852d20c72
md"""
 $$\varphi(°) \to \cos \varphi$$  $(@bind phi₇ PlutoUI.Slider(-90:1:90, default=60, show_value=true))
"""

# ╔═╡ c6f94497-b544-417f-a479-f6558be1edc7


# ╔═╡ 3f3ef7e6-095f-4b87-8dd4-cb98cce33f9a
md"""
## 💻 Efeitos de $$I_{exc}$$ e cosφ em $$U=f(I)$$
"""

# ╔═╡ 7ed35606-3e63-43a8-b946-5bd7679d534a
md"""
A corrente de campo, $$I_{exc}$$, afeta a FEM e também o valor da reatância síncrona, em especial se a máquina estiver a funcionar na zona de saturação da característica magnética:
"""

# ╔═╡ 8a70bab4-014b-4f85-9ecb-821f9c4ed204
aside(md"""
!!! nota
	O estudante deverá procurar perceber as implicações qualitativas das variações da corrente de campo, $$I_{exc}$$, e do factor de potência, $$\cos \varphi$$, na característica externa de um alternador síncrono.
""", v_offset=100)

# ╔═╡ 42845857-b6d5-415f-abb8-072977e8c3db
md"""
 $$I_{exc}(\rm A)$$ $(@bind Iexc PlutoUI.Slider(23:0.5:33.5, default=33.5,show_value=true)) $$\quad\quad\quad \varphi(°) \to \cos\varphi$$ $(@bind phi₆ PlutoUI.Slider(-90:1:90, default=30, show_value=true))
"""

# ╔═╡ 8f85182b-136d-42f2-b900-d234f2d52739
begin
	E₀_iₑₓ = E₀_i(Iexc) 				# data interpolation in magnetic characteristic for Iexc
	Icc_iₑₓ = Icc_i(Iexc) 				# data interpolation in short-circuit characteristic for Iexc
	Zₛ_iₑₓ = E₀_iₑₓ/(Icc_iₑₓ/√3) 		# calculation of Zₛ as a function of field current
	Xₛ_iₑₓ = √(Zₛ_iₑₓ^2-Rₛ^2)	  		# calculation of Xₛ as a function of field curren
	Xₛ_iₑₓ = round(Xₛ_iₑₓ, digits=3)
	Iexc, E₀_iₑₓ, Icc_iₑₓ, Xₛ_iₑₓ
end

# ╔═╡ cb82f279-22e4-4c36-bf5a-32b10aea7606
begin
	φ₆ = deg2rad(phi₆)
	θ₆ = atan(Xₛ_iₑₓ/Rₛ)
	δ₆ = asin.((Zₛ_iₑₓ/E₀_iₑₓ).*I₃*sin(θ₆+φ₆))
	U₆ = E₀_iₑₓ*cos.(δ₆) - Zₛ_iₑₓ.*I₃*cos(θ₆+φ₆)
	plot(I₃, U₆, 
		title="U =f(I)", xlabel = "I(A)", ylabel="U(V)", 
		ylims=(0,3000), xlims=(0,160), 
		framestyle=:origin, minorticks=5, legend=:none)
end

# ╔═╡ b7d03e6c-bb80-48ee-8df4-2cac6fc3e983


# ╔═╡ fae8d4d5-a0bd-4000-94d0-e030d9ee723e
md"""
# d) Cálulo da corrente de excitação para uma dada carga
**A corrente de excitação o alternador para alimentar um motor assíncrono trifásico a uma tensão de $1$ kV, sabendo que o motor desenvolve uma potência de $150$ kW com um fator de potência de $0.832$ e um rendimento de $90$ %.**

**Nota:** Admita que a impedância síncrona, $$Z_s$$, é igual à obtida da alínea anterior.
"""

# ╔═╡ 39b0c0d9-05e1-43eb-97e2-0ab169f9a2b0


# ╔═╡ cadba82d-785a-4306-9407-d65eca10c2b3
md"""
Considerando desprezáveis as perdas rotacionais no motor assíncrono, $$p_{rot}=0 \Rightarrow P_u=P_d$$, por conseguinte, a corrente na linha vem:

$$I_L=\frac{P_u}{\eta \space \sqrt{3} \space U_c \space \cos\varphi}$$
os vetores da corrente e da tensão por fase do alternador (estator em triângulo) vêm dados por:
$$\overline{I}=\dfrac{I_L}{\sqrt{3}}∠\varphi \quad$$ e $$\quad \overline{U}=U_c∠0°$$
"""

# ╔═╡ db9572b9-50ea-438d-a82d-6befe3aa8d59


# ╔═╡ b4c5bcd1-830b-49d5-ad25-df89de14d59a
md"""
# Bibliografia
"""

# ╔═╡ a66b3097-edb2-40e2-affa-071ea2ebb82f
md"""
[^Malea2004]:  Malea, J.M., Balaguer, E.F., Problemas resueltos de máquinas eléctricas rotativas, Publicações da Universidade de Jaume I, Espanha, 2004.
"""

# ╔═╡ 249d4cdb-a1dd-4314-9799-63332d8b6da4
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

# ╔═╡ 65f2c812-bf9f-4909-8032-90e683b6a1bc
md"""
# *Notebook*
"""

# ╔═╡ 6a1038a4-81c8-450b-a91e-d0018570b760
md"""
## Notação complexa em `Julia` 
"""

# ╔═╡ af8b8b2f-f554-4da5-a94c-3f53f33db0e4
md"""
Na linguagem `Julia` os números complexos são nativamente apresentados na forma retangular, sendo a unidade imaginária representada por `im`.\
No bloco seguinte definem-se o operador imaginário, `j`, e a função fasor, `∠(x)`, de modo a facilitar a escrita comummente utilizada em engenharia eletrotécnica quanto à representação de grandezas complexas, na forma retangular e polar, respectivamente. 
"""

# ╔═╡ a5b749e0-fcf5-484e-8c63-fdda8cb8e050
begin
	j = Base.im 				# to use the Julia imaginary unit, "im", as "j"
	∠(θ) = cis(deg2rad(θ))  	# to use phasors with angle in degrees. 
	#Note: to write the symbol "∠", do: \angle + [TAB] key
end;

# ╔═╡ ae01b249-cb76-43ae-9938-f489b93cc0ea
begin
	φ₁ = rad2deg(φ)
	φ₁ = round(φ₁, digits=3)
	K = 8 						# scale factor for the current vector
	I⃗ₙ = (K*Iₙ)∠(φ₁)
	U⃗ = (U)∠(0)
	RₛI⃗ₙ = (Rₛ*Iₙ)∠(φ₁)
	jXₛI⃗ₙ = (Xₛ*Iₙ)∠(φ₁+90)
	E⃗₀ = (E₀)∠(δ)
	
	plot([0, U⃗], arrow=:closed, legend=:topleft, label="U∠0°")
	
	plot!([0, I⃗ₙ], arrow=:closed, label="Iₙ∠φ")
	
	plot!([U⃗, U⃗+RₛI⃗ₙ], arrow=:closed, label="RₛIₙ∠φ")
	
	plot!([U⃗+RₛI⃗ₙ, U⃗+RₛI⃗ₙ+jXₛI⃗ₙ], arrow=:closed, label="XₛIₙ∠(φ+90°)")
	
	plot!([0, E⃗₀], arrow=:closed, label="E₀∠δ",
		  minorticks=5, ylims=(-1000,1000), xlims=(0,2000), size=(600,600))
end

# ╔═╡ 4287947f-5fcc-4400-b4ea-7ddb29d259cf
begin
	φ₂ = deg2rad(phi₂)
	sinδ₂ = (Zₛ/E₀)*I₂*sin(θ+φ₂)
	δ₂ = asin(sinδ₂)
	U₂ = E₀*cos(δ₂) - Zₛ*I₂*cos(θ+φ₂)
	δ₂ = rad2deg(δ₂)
	φ₂ = rad2deg(φ₂)
	I⃗₂ = (K*I₂)∠(φ₂)
	U⃗₂ = (U₂)∠(0)
	RₛI⃗₂ = (Rₛ*I₂)∠(φ₂)
	jXₛI⃗₂ = (Xₛ*I₂)∠(φ₂+90)
	E⃗₀₂ = (E₀)∠(δ₂)
	
	plot([0, U⃗₂], arrow=:closed, legend=:bottomright, label="U∠0°", linewidth=2)
	
	plot!([0, I⃗₂], arrow=:closed, label="I∠φ", linewidth=2)
	
	plot!([U⃗₂, U⃗₂+RₛI⃗₂], arrow=:closed, label="RₛI∠φ", linewidth=2)
	
	plot!([U⃗₂+RₛI⃗₂, U⃗₂+RₛI⃗₂+jXₛI⃗₂], arrow=:closed, label="XₛI∠(φ+90°)", linewidth=2)
	
	plot!([0, E⃗₀₂], arrow=:closed,minorticks=5, label="E₀∠δ", linewidth=2,
		  ylims=(-1500,1500), xlims=(0,3000), size=(600,600))
	
	# locus of EMF
	δ_locus = -5:1:90
	E⃗₀_locus = (E₀)∠.(δ_locus)
	
	plot!(E⃗₀_locus, linestyle=:dash, label="locus de E₀∠δ")
	
	
	# locus of I
	
	φ_locus = -90:1:90
	I⃗₂_locus = (K*I₂)∠.(φ_locus)
	
	plot!(I⃗₂_locus, linestyle=:dash, label="locus de I∠φ")
end

# ╔═╡ c95b31b8-bfad-47d5-a5c8-bfb5340f76e3
begin
	φ₇=deg2rad(phi₇)
	I₃_=(I₃)∠(φ₇)
	#E₀₇_=(U₀)∠(0).+(Rₛ+(Xₛ₀)im).*I₃_        # opção 1: algo não está correcto...
	#E₀₇_=(U₀)∠(0).+((Zₛ₀)∠(θ₀)).*I₃_        # opção 2: pior ainda...
	#E₀₇=abs.(E₀₇_)                          # faz parte das opções 1 e2
	
	# opção 3: passando o cálculo vectorial para escalar, determinando 1º (tan δ) para depois determinar E₀:
	tanδ₇=(Zₛ₀.*I₃*sin(θ₀+φ₇))./(U₀.+Zₛ₀.*I₃*cos(θ₀+φ₇))  
	δ₇=atan.(tanδ₇)
	if δ₇==0
		E₀₇=(U₀+Zₛ₀.*I₃*cos(θ₀+φ₇))
		else
		E₀₇=Zₛ₀.*I₃*sin(θ₀+φ₇)./sin.(δ₇)
		end
	
	# interpolação da característica magnética para E₀:
	i_E₀=Spline1D(fem, Iₑₓ, k=1, bc="extrapolate")	
	iₑₓ_E₀=i_E₀(E₀₇)
	
	# traçado da caracterítica de regulação:
	plot(I₃, iₑₓ_E₀, 
		title="Iₑₓ =f(I)",
		xlabel = "I(A)", ylabel="Iₑₓ(A)", 
		ylims=(0,40), xlims=(0,110), 
		framestyle=:origin, minorticks=5, legend=:none)
end

# ╔═╡ 1645c653-c4e6-45af-969c-440981b30bd0
begin
	(Pu, cosφₘ, η, Uₘ) = (150e3, 0.832, 0.9, 1e3) 	 	# data from paragraph d)
	Iₗᵢₙₕₐ = Pu / (η*√3*Uₘ*cosφₘ)
	φₘ = -acos(cosφₘ)
	φₘ = rad2deg(φₘ)
	E⃗₀ₘ = (Uₘ)∠(0) + (Rₛ+Xₛ*im)*((Iₗᵢₙₕₐ/√3)∠(φₘ))
	E₀ₘ = abs(E⃗₀ₘ)									# absolute value of EMF vector
	
	# interpolation of the magnetic characteristic to the calculated EMF:
	iₑₓ_E₀ₘ = i_E₀(E₀ₘ)
	iₑₓ_E₀ₘ = round(iₑₓ_E₀ₘ, digits=1)

	E₀ₘ, iₑₓ_E₀ₘ
end

# ╔═╡ 94260acb-1a29-4de8-b46e-a1c440460847
md"""
Calculando a FEM por resolução da equação vetorial de $$\overline{E}_0$$, obtém-se a corrente de campo, $$I_{exc}$$, consultando a característica magnética do alternador, obtendo-se, $$I_{exc}=$$ $iₑₓ_E₀ₘ A.
"""

# ╔═╡ 2970ee17-90ee-4827-acb2-e70b2e4d1f51
md"""
## *Setup*
"""

# ╔═╡ 319dce21-8655-4f72-8b8d-1f5f934416b5
md"""
Documentação das bibliotecas Julia utilizadas:  [Dierckx](https://github.com/kbarbary/Dierckx.jl), [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html).
"""

# ╔═╡ cb63050b-07c0-46ba-8b88-be17aeef96ac
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ 88b36341-02ed-4043-8a9f-672340bf194f
TableOfContents(title="Índice")

# ╔═╡ 9734b80e-1683-4812-9227-f5e61154086c
aside((md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""), v_offset=-100)

# ╔═╡ 15984de3-1e84-41c9-8193-5fa3a4cb9f1c
md"""
|  |  |
|:--:|:--|
|  | This notebook, [StandAloneSynGen.jl](https://ricardo-luis.github.io/me-2/StandAloneSynGen.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
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

[compat]
Dierckx = "~0.5.4"
Plots = "~1.41.7"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.83"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.0"
manifest_format = "2.1"
project_hash = "28d1b248ade775add295ecdc82b240bba5888b7e"

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
# ╟─aeeef650-bea8-44d4-89d5-fbf01f94ba60
# ╟─55e44178-ff2c-4467-b8b5-afa0d360cdcf
# ╟─89db506b-737e-4916-a495-df388314d268
# ╟─520962f0-6513-4615-ba08-a973b851ec8f
# ╠═99485bd5-46b8-425b-8974-6056c903b062
# ╠═8da1cb6d-5f5a-49b1-9ab8-9a00d229b519
# ╟─82ddc4f5-e411-48da-abab-cc2029ee02f0
# ╟─f52ee282-219a-4e7d-b1b6-faa4eff673f2
# ╟─db6deedc-de66-43e6-955c-b4a949cd659f
# ╟─f3c0c91a-6728-4178-a7cd-02527d7df872
# ╟─0a44521c-58b4-47d3-968c-d345799e42bb
# ╟─b90f442f-41aa-485b-b0f0-170e282c028c
# ╠═46318b60-7480-44f8-94bc-10f69a425d54
# ╟─90712d40-b1a5-445e-a1da-af62ecab7e59
# ╠═638d41c0-4a34-4a30-9928-ba88507334af
# ╟─9649494f-8378-459f-b079-d0566f2af8fb
# ╟─b9f959bf-abc2-4cc8-9f1d-584bb4728e89
# ╟─59f534f3-da67-406c-ae7f-9f3ddf13d1fe
# ╠═3570ce87-a57d-4abb-8477-f33957697952
# ╟─94c43668-0ddd-4550-9bca-5b05a1ede581
# ╟─5e679cb2-dd7f-4cf5-8035-54ae205eba1e
# ╠═5d555c37-3ea9-4315-b31f-c5ce86896160
# ╟─69998624-54dc-49a6-9053-0322c72982ea
# ╠═67329e1c-c84a-4a64-abdf-d086b59cee6d
# ╟─32294557-b288-4cff-9d2e-60e9dc3eeb1c
# ╟─a2c4ba4e-56fa-4aaa-ba4a-5b5acb3cb2d8
# ╠═ccec9d74-f4aa-4254-89a1-f99e2e1cf653
# ╟─7df06422-db2c-4494-97c1-6ed2a1bc77eb
# ╟─87bf1d67-5f81-496e-a6ee-821b3f3eb1b0
# ╟─ce99f675-29ac-4413-94a9-febe1243e79d
# ╠═2385f6d9-1770-4fee-a7ab-3322f2d6e9ed
# ╟─e3a3c2f7-43f5-40ab-8693-9affc1130373
# ╟─ff08e1d0-6acd-4b46-ab75-51329cb00c22
# ╟─57790c82-9d40-4244-8b5d-3fcf98ce12e7
# ╠═ae01b249-cb76-43ae-9938-f489b93cc0ea
# ╟─e934fad8-c4fe-4e7f-bc64-e1c3f3e52460
# ╟─96d3e48e-60bc-4c97-aac4-6517502fa936
# ╟─f68a29b1-64c3-466b-987b-0c66b8385af3
# ╟─4287947f-5fcc-4400-b4ea-7ddb29d259cf
# ╟─d3581eff-e1c7-4e01-b722-3d94ff428746
# ╟─14df28f1-6cb0-4e18-b5f0-4c8f94d02a56
# ╟─76b147a2-d33f-49ef-8236-444818042a12
# ╠═f50dc850-e32d-4fb3-afd2-0217cf8df1fc
# ╠═2dd82e2e-675f-40dd-882f-fe90db117589
# ╠═b350ee3d-7705-4712-a9bd-d16d4a83f89b
# ╟─cd338db8-8a5b-4ebf-a93d-95b1a7433de7
# ╟─ba2a8447-a8a0-4ce8-9d53-03a0369703c6
# ╟─8a1756c9-6d37-4541-ba8d-586e95b4feda
# ╟─9238a818-157c-4523-b6b2-139faf8ebe44
# ╟─58011f3c-364f-42b7-a9de-17fe736f80d1
# ╠═894c1642-9272-4624-b7a3-c8a882fbc337
# ╟─079234a4-3aa6-4932-8a25-2a8c8f290368
# ╠═373a9233-e5d1-4c18-a1aa-162f3a1a00be
# ╟─b2a13c34-84be-4c7d-bcd8-9186a4975559
# ╠═fee556d9-aa55-4187-b83c-afa2173e2adb
# ╟─1daacb53-b03f-476d-9ab0-c1dc59356147
# ╟─889e92f2-9104-4206-8e2e-785fc750a2c2
# ╟─33bd0f07-6c4c-4e1b-bad1-719871b4e56e
# ╟─1e30acf6-44bd-4caa-a461-ec358da607ea
# ╟─1dc1c2e2-11e6-4d30-ac49-4797117a5dae
# ╠═81223b60-4ca2-445e-9ce6-23261cd0e525
# ╟─8436976e-60cb-4904-aeb3-c9c65562a7a6
# ╟─95aedd7b-68fd-49fc-aa2d-ef5852d20c72
# ╟─c95b31b8-bfad-47d5-a5c8-bfb5340f76e3
# ╟─c6f94497-b544-417f-a479-f6558be1edc7
# ╟─3f3ef7e6-095f-4b87-8dd4-cb98cce33f9a
# ╟─7ed35606-3e63-43a8-b946-5bd7679d534a
# ╠═8f85182b-136d-42f2-b900-d234f2d52739
# ╟─8a70bab4-014b-4f85-9ecb-821f9c4ed204
# ╟─42845857-b6d5-415f-abb8-072977e8c3db
# ╠═cb82f279-22e4-4c36-bf5a-32b10aea7606
# ╟─b7d03e6c-bb80-48ee-8df4-2cac6fc3e983
# ╟─fae8d4d5-a0bd-4000-94d0-e030d9ee723e
# ╟─39b0c0d9-05e1-43eb-97e2-0ab169f9a2b0
# ╟─cadba82d-785a-4306-9407-d65eca10c2b3
# ╟─94260acb-1a29-4de8-b46e-a1c440460847
# ╠═1645c653-c4e6-45af-969c-440981b30bd0
# ╟─db9572b9-50ea-438d-a82d-6befe3aa8d59
# ╟─b4c5bcd1-830b-49d5-ad25-df89de14d59a
# ╟─a66b3097-edb2-40e2-affa-071ea2ebb82f
# ╟─249d4cdb-a1dd-4314-9799-63332d8b6da4
# ╟─65f2c812-bf9f-4909-8032-90e683b6a1bc
# ╟─6a1038a4-81c8-450b-a91e-d0018570b760
# ╟─af8b8b2f-f554-4da5-a94c-3f53f33db0e4
# ╠═a5b749e0-fcf5-484e-8c63-fdda8cb8e050
# ╟─2970ee17-90ee-4827-acb2-e70b2e4d1f51
# ╟─319dce21-8655-4f72-8b8d-1f5f934416b5
# ╠═18c20096-84c1-4ec0-bb6d-185338676ced
# ╟─cb63050b-07c0-46ba-8b88-be17aeef96ac
# ╠═88b36341-02ed-4043-8a9f-672340bf194f
# ╟─9734b80e-1683-4812-9227-f5e61154086c
# ╟─15984de3-1e84-41c9-8193-5fa3a4cb9f1c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
