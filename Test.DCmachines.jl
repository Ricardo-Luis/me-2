### A Pluto.jl notebook ###
# v0.20.15

#> [frontmatter]
#> chapter = 1
#> section = 8
#> order = 8
#> image = "https://github.com/Ricardo-Luis/me-2/blob/cf9b5498fbc9ea264c8b0702aecf5e89dca05b97/images/card/Test.DCmachines.png?raw=true"
#> title = "Teste 03.nov.2022"
#> layout = "layout.jlhtml"
#> tags = ["lecture", "module2"]
#> date = "2024-09-09"
#> description = "Apresenta-se a resolução de um teste sobre máquinas de corrente contínua, centrado na análise de um grupo motor-gerador constituído por duas máquinas idênticas. Na secção dedicada ao gerador, determinam-se a velocidade de acionamento e o rendimento do grupo, traçando-se ainda comparativamente as características externas para diferentes modos de excitação. Abordam-se também questões construtivas, como o enrolamento rotórico adequado para elevadas correntes do induzido e o papel dos polos auxiliares. Na parte referente ao motor, calculam-se a velocidade, a corrente e o binário desenvolvido, analisando-se ainda condições de embalamento e a característica de binário, incluindo o efeito de um reóstato de campo."
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

# ╔═╡ 1b1df283-8089-41fc-b08f-e0e0d72253d8
using Plots,EasyFit, PlutoUI, PlutoTeachingTools, Roots, Dierckx
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - EasyFit.jl, interface for obtaining fits of 2D data
  - Roots.jl,  simple routines for finding roots, or zeros, of scalar functions
  - Dierckx.jl, tool for data interpolation
=#

# ╔═╡ 9b9d7372-f136-499a-a900-e999a2a6784e
Columns(md"""
	`Test.DCmachines.jl`""", md"""
	`Language:` $(@bind lang Select([
		"pt" => "Português",
		"en" => "English",
		]))""", md"""
	`Last update: 09·09·2024`""")

# ╔═╡ ea3e2579-177a-477f-97f6-71ebe0f014cd
md"""
---
$\textbf{Licenciatura em Engenharia Eletrotécnica }$

$\text{MÁQUINAS ELÉTRICAS 2}$ 

$\textbf{1º Teste de 03 de novembro de 2022}$ 
---
"""

# ╔═╡ 0823bba0-4ee5-41b4-bf9c-f1914fdbc7a3
if lang == "pt"
	md"""
	$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Resolução de teste sobre máquinas elétricas de corrente contínua}}}$
	"""
elseif lang == "en"
	md"""
	$\colorbox{Bittersweet}{\textcolor{white}{\textbf{DC Electrical Machines Test Solution}}}$
	"""
end

# ╔═╡ 7ca9e6c8-5e20-4215-a2eb-97798306a060
if lang == "pt"
	md"""
	Duas máquinas de corrente contínua de iguais características constituem um grupo motor-gerador, a funcionar em regime permanente, de acordo com os dados presentes no seguinte esquema elétrico:
	"""
elseif lang == "en"
	md"""
	Two direct current machines with the same characteristics form a motor-generator group, operating at steady state, according to the data presented in the following electrical scheme:
	"""
end

# ╔═╡ 0257581c-670d-437d-9d9d-c1620c5a60c1
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:
	raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/Test.DCmachines/TestDCscheme.drawio"

# viewer_url build:
	viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1#U" * raw_url

# HTML:
HTML("""
<iframe frameborder="0" style="width:100%;height:500px;" 
        src="$(viewer_url)">
</iframe>
""")
end

# ╔═╡ 1e9ffcd8-aaab-4387-a60e-930deaf1f24a
if lang == "pt"
	md"""
	Conhecem-se ainda os seguintes dados:
	"""
elseif lang == "en"
	md"""
	The following data are also known: 
	"""
end

# ╔═╡ 616efd77-a81e-4242-9110-cb73b7953497
begin
	α = 1/300 			# turns ratio, α=Ns/Nf
	pᵣₒₜ = 3000 		# W, pᵣₒₜ: rotational losses (mechanical and core losses)
	ΔE = 12.9 			# V, ΔE: voltage drop due to armature reaction (for Iₐ=150A)
end;

# ╔═╡ 929cbbe0-5167-11ed-22ad-3d923623a1e8
begin
	i=[0, 0.2, 0.4, 0.6, 0.8, 1.0]  		# A, field current values
	E=[5.0, 180, 225, 240, 246, 250]   		# V, FEM values
	n_mag=1000 								# rpm, speed of the no-load characteristic
end;

# ╔═╡ 1ceaa326-46f1-4dba-8288-2d06345ca41d
if lang == "pt"
	md"""
	Característica magnética às $(n_mag) rpm:
	"""
elseif lang == "en"
	md"""
	No-load characteristic at 1000 rpm:
	"""
end

# ╔═╡ b64be4f2-d16c-4d40-8437-4bad945cff01
begin
	FIT_E = fitexp(i, E, n=2) 			# Trendline for no-load characteristic
	
	# Interpolated no-load characteristic
	E_i = Spline1D(FIT_E.x, FIT_E.y, k=3, bc="extrapolate") # to obtain FEM
	i_E = Spline1D(FIT_E.y, FIT_E.x, k=3, bc="extrapolate") # to obtain field current
	
	scatter(i, E, xlabel = "i (A)", ylabel="E (V)", legend=:none)					# plot no-load data points
	plot!(FIT_E.x, FIT_E.y)			# plot the trendline
	
	# To test the interpolated no-load characteristic:
	
	#If = 0:0.01:1 				
	#U0 = 5.01:1:250
	
	#i2E = E_i.(If)
	#E2i = i_E.(U0)
	
	#plot!(If, i2E)
	#plot!(E2i, U0)
end

# ╔═╡ a6ff8b62-6fd0-45ff-8453-2c5b0a630219
if lang == "pt"
	md"""
	## Dados do grupo motor-gerador
	"""
elseif lang == "en"
	md"""
	## Electric circuit data of motor-generator set 
	"""
end

# ╔═╡ 62df9520-f4b6-41e5-a75f-8ad257ef3529
begin
	# DC motor-generator set (identical machines)
	Rₐ = 0.114   		# Ω, armature resistance
	Rf = 250 	 		# Ω, shunt/independent field inductor resistance
	Rₛ = 0.072 	 		# Ω, serie field inductor resistance
	Tmec = 328.65 		# Nm, mechanical torque

	# Generator
	Iₐᴳ = 150 			# A, armature current
	Rᵣₕᴳ = 575 			# Ω, Rf field rheostat
	Uᴳ = 330 			# V, output/load voltage

	# Motor
	Iₐᴹ = 150 			# A, armature current
	Rᵣₕᴹ = 580 			# Ω, Rf field rheostat
	Uᴹ = 415 			# V, input/supply voltage
end;

# ╔═╡ 016d56be-2d99-4a20-9908-a4fb7c347af0


# ╔═╡ 7d2b527d-da2b-4704-a931-3cc06d5a5215
if lang == "pt"
	md"""
	# I - Gerador
	"""
elseif lang == "en"
	md"""
	# I - Generator
	"""
end

# ╔═╡ 4153a634-6797-449f-8c5b-25355b6a5507
md"""
## a) $n \to (I_n, U_n)$ 
"""

# ╔═╡ fc2bd53a-7d0c-4ca8-adef-ddf7b700954b
if lang == "pt"
	md"""
	**Determine a velocidade de acionamento necessária para o gerador funcionar nas condições indicadas;**
	"""
elseif lang == "en"
	md"""
	**Calculate the drive speed required for the generator to operate under the indicated conditions;**
	"""
end

# ╔═╡ b2792a51-9371-4406-9224-ba96588827c7
if lang == "pt"
	md"""
	Cálculo da corrente de excitação do gerador CC:
	"""
elseif lang == "en"
	md"""
	Calculation of DC generator field current:
	"""
end

# ╔═╡ 54ccccd5-a2ce-42cf-85c5-8640fa0afcb4
Ifᴳ = Uᴳ / (Rf + Rᵣₕᴳ) 		# A, field current

# ╔═╡ 42335ad4-de0a-4ebd-9c2a-729c4a23cf7d
if lang == "pt"
	md"""
	Leitura da força eletromotriz na característica magnética às 1000rpm para o valor da corrente de excitação obtido:
	"""
elseif lang == "en"
	md"""
	Electromotive-force from no-load magnetic characteristic at 1000rpm for the obtained field current:
	"""
end

# ╔═╡ eb2b2d53-f1b3-4798-b2fc-ba42b2914826
begin
	E₀ᵐᵃᵍ = E_i(Ifᴳ)		# V, read electromotive force from no-load curve for Ifᴳ
	kϕ₀ = E₀ᵐᵃᵍ / n_mag  	# V/rpm, magnetic flux (optional)
	E₀ᵐᵃᵍ, kϕ₀
end

# ╔═╡ da08e82c-f364-4102-9648-cf400cea0578
if lang == "pt"
	md"""
	Considerando a queda de tensão nas escovas desprezável, $$\Delta U_{brushes} \approx 0 \rm V$$, a força eletromotriz (FEM) do gerador CC, para as condições de funcionamento indicadas, vem dada por:

	$$E_0=U^G + R_a I_a^G + \Delta E$$
	"""
elseif lang == "en"
	md"""
	Considering that voltage drop on the brushes is negligible, $$\Delta U_{brushes} \approx 0 \rm V$$, the electromotive-force (EMF) of the DC generator, for the indicated operating conditions, is given by:
		
	$$E_0=U^G + R_a I_a^G + \Delta E$$
	"""
end

# ╔═╡ a5964481-bfc3-429a-94af-6eac8d7335b2
E₀ = Uᴳ + Rₐ * Iₐᴳ + ΔE  	# V, FEM

# ╔═╡ 9e81564f-a752-4fcf-8309-aedbf46e3d21
if lang == "pt"
	md"""
	Como a FEM do gerador CC é diretamente proporcional ao fluxo magnético e à velocidade de acionamento, para as condições de funcionamento indicadas, vem dada por:

	$$E_0=k\phi_0 \: n$$

	e $$k\phi_0$$ depende unicamente da corrente de excitação, ou seja:

	$$k\phi_0=\frac{E_0^{mag}}{n_{mag}}=\frac{E_0}{n}$$

	Assim, a velocidade do grupo motor-gerador, vem dada por:
	"""
elseif lang == "en"
	md"""
	As the EMF of the DC generator is directly proportional to the magnetic flux and the drive speed, for the indicated operating conditions, it is given by:

	$$E_0=k\phi_0 \: n$$

	and $$k\phi_0$$ depends only on the field current, that is:

	$$k\phi_0=\frac{E_0^{mag}}{n_{mag}}=\frac{E_0}{n}$$

	Thus, the speed of the motor-generator set is given by:
	"""
end

# ╔═╡ e4cba508-69ed-4c0d-b3d8-85cd67b375e0
begin
	nᴳ = (E₀/E₀ᵐᵃᵍ)* n_mag  	# rpm, speed 
	# nᴳ = E₀ / kϕ₀ 			# rpm, speed (other option)
	nᴳ = round(Int, nᴳ) 		# rpm, speed rounded to unit
end

# ╔═╡ cd05b997-f3ec-4e7f-a590-75fb3f8c5eca


# ╔═╡ 99718cff-350e-4614-a9bc-b8995e5c1024
if lang == "pt"
	md"""
	## b) $n$ através do balanço de potência. $\eta$ do grupo motor-gerador
	"""
elseif lang == "en"
	md"""
	## b) $n$ using gen. power balance. $\eta$ of motor-gen. group
	"""
end

# ╔═╡ c115c741-514d-4237-8c92-c9a7e51dbec0
if lang == "pt"
	md"""
	**Utilize o balanço de potências do gerador para confirmar o resultado anterior. Determine o rendimento do grupo motor-gerador;**
	"""
elseif lang == "en"
	md"""
	**Use the generator power balance to confirm the previous result. Determine the efficiency of the motor-generator group;**
	"""
end

# ╔═╡ b794ec89-73ba-4543-86db-47b930ba2cd2
if lang == "pt"
	md"""
	Através do balanço de potência de cada máquina CC obtêm-se as respetivas potências absorvidas e úteis:
	"""
elseif lang == "en"
	md"""
	Through the power balance of each DC machine, the respectives inputs and output powers are obtained:
	"""
end

# ╔═╡ 12461786-f362-4f7b-9f1c-1ea0b6256947
Pᵤᴳ= Uᴳ * Iₐᴳ 							# W, generator output power

# ╔═╡ 39917674-e6ad-405f-bc66-1d37437b4fda
pⱼfᴳ = Uᴳ*Ifᴳ 							# W, generator field circuit Joule losses

# ╔═╡ a0a91e9b-0816-45ca-b46e-da7206406352
pⱼₐᴳ = Rₐ * Iₐᴳ^2  						# W, generator armature Joule losses

# ╔═╡ 93b2bdb6-0c50-459f-8a05-5b9f94276b17
Pmec = Pᵤᴳ + pⱼfᴳ + pⱼₐᴳ + pᵣₒₜ 		# W, generator/motor input/output power

# ╔═╡ 9f8bb91a-685f-4f3b-9826-2aa05c7fbe16
Pᵢₙᴹ = Uᴹ * Iₐᴹ + (Uᴹ^2)/(Rf+Rᵣₕᴹ)		# W, motor input power

# ╔═╡ 0cd99825-9f0f-420e-904f-412ca8f88660
if lang == "pt"
	md"""
	O rendimento do grupo motor-gerador é obtido por:
		
	$$\eta=\frac{P_u^G}{P_{in}^M}$$

	Ou através do produto dos rendimentos de cada uma das máquinas CC:
		
	$$\eta=\eta^M \: \eta^G =\frac{P_u^M}{P_{in}^M}\frac{P_u^G}{P_{in}^G}$$

	onde se considera que o acoplamento mecânico entre as máquinas CC é perfeito, ou seja: $$P_u^M=P_{in}^G=P_{mec}=$$ $(Pmec) $$\rm W$$
	"""
elseif lang == "en"
	md"""
	The efficiency of motor-generator set is obtained by:
	
	$$\eta=\frac{P_u^G}{P_{in}^M}$$

	Or through the product of the efficiency of each DC machines:
		
	$$\eta=\eta^M \: \eta^G =\frac{P_u^M}{P_{in}^M}\frac{P_u^G}{P_{in}^G}$$

	where it is considered that the mechanical coupling between the DC machines is perfect, that is: $$P_u^M=P_{in}^G=P_{mec}=$$ $(Pmec) $$\rm W$$
	"""
end

# ╔═╡ 1fcd9e30-cd4e-4aff-b52d-0d4a84c34d9d
begin
	ηᴳ = Pᵤᴳ / Pmec 		# Generator efficiency
	ηᴹ = Pmec / Pᵢₙᴹ 		# Motor efficiency
	ηᴹᴳ = ηᴹ * ηᴳ 			# Motor-generator set efficiency

	# percent values and their rounded values
	ηᴳ=round(ηᴳ*100, digits=1)
	ηᴹ=round(ηᴹ*100, digits=1)
	ηᴹᴳ=round(ηᴹᴳ*100, digits=1)

	#results:
	ηᴳ, ηᴹ, ηᴹᴳ
end

# ╔═╡ 6c53cb0f-ed8c-44b8-a989-20f7681c4596
if lang == "pt"
	md"""
	Conhecidos o binário mecânico e potência mecânica aplicados ao gerador CC, $$T_{mec}$$ e $$P_{mec}$$, obtém-se a velocidade de acionamento:
	"""
elseif lang == "en"
	md"""
	Knowing the mechanical torque and mechanical power applied to the DC generator, $$T_{mec}$$ and $$P_{mec}$$, the drive speed is obtained:
	"""
end

# ╔═╡ 765f1a81-ed15-48a2-b2a5-184410410736
let
	nᴳ = Pmec / Tmec 			# rad/s, angular speed of motor-generator set 
	nᴳ = 60 * nᴳ / (2π)         # rpm, angular speed units conversion: rad/s → rpm
	nᴳ = round(Int, nᴳ)			# rpm, drive speed rounded to unit
end

# ╔═╡ 013705ab-87fc-4cf8-a523-a4dd412a06ff


# ╔═╡ 2b3f8456-6b70-4b7f-997c-a7d94db46c6b
if lang == "pt"
	md"""
	## c) 💻 $U=f(I)$: derivação, independente, composta aditiva
	"""
elseif lang == "en"
	md"""
	## c) 💻 $U=f(I)$: shunt, independent, compound aditive
	"""
end

# ╔═╡ 0a6f6c04-7856-495f-ac62-09c865e60472
if lang == "pt"
	md"""
	**Trace qualitativamente e de forma comparativa as características externas do gerador nos modos de excitação: derivação, independente e composta aditiva. As três características têm de passar pelo ponto de funcionamento nominal, $(I_n, U_n)$.**
	"""
elseif lang == "en"
	md"""
	**Trace qualitatively and comparatively the external (load) characteristics of the generator in the excitation modes: shunt, independent and additive compound. All three characteristics must pass through the rated operation point, $(I_n, U_n)$.**
	"""
end

# ╔═╡ e0b9823e-1e98-4b87-a96f-c9472806f957
if lang == "pt"
	md"""
	> Para a resolução desta questão optou-se pelo desenvolvimento de uma solução quantitativa, determinando computacionalmente a solução numérica de cada característica externa, tirando partido da linguagem de programação científica `Julia` e do ambiente interativo do *notebook* `Pluto.jl`.
	"""
elseif lang == "en"
	md"""
	> To solve this question, a quantitative solution was developed, computationally determining the numerical solution of each external characteristic, taking advantage of the scientific programming language `Julia` and the interactive *notebook* environment `Pluto.jl`.
	"""
end

# ╔═╡ e645b64d-c6a3-48b0-8ed0-5525bef418e1
if lang == "pt"
	md"""
	Escolha os valores nominais $$(I_n,\: U_n)$$:
	"""
elseif lang == "en"
	md"""
	Choose the nominal values $$(I_n,\: U_n)$$:
	"""
end

# ╔═╡ acd3ce49-2f6b-42a2-ba90-03c46f539fb7
md"""
 $$I_n (\rm A):$$ $(@bind In PlutoUI.Slider(0:1:200, default=150, show_value=true)) $$\quad\quad\quad U_n (\rm V):$$  $(@bind Un PlutoUI.Slider(0:1:250, default=200, show_value=true)) 
"""

# ╔═╡ afee0704-03a6-4403-afe0-56b5a4a1df40
if lang == "pt"
	md"""
	Modifique a tensão de vazio, $$U_0$$, para cada tipo de excitação, para que a respetiva característica externa contenha $$(I_n, U_n)$$:
	"""
elseif lang == "en"
	md"""
	Change the no-load voltage, $$U_0$$, for each field type generator, in order to load characteristic contain $$(I_n, U_n)$$ in the plot results:
	"""
end

# ╔═╡ cd5aeeee-5ab6-4589-a6e7-25fb6115b283
md"""
| **Shunt** | **Independent** | **Compound⁺** |
|:-----:|:-----:|:-----:|
| $$U_0\:(\rm V)$$ | $$U_0\:(\rm V)$$ | $$U_0\:(\rm V)$$ |
| $(@bind U₀ₛₕ PlutoUI.Slider(6:1:250, default=175, show_value=true)) | $(@bind U₀ᵢₙ PlutoUI.Slider(6:1:250, default=175, show_value=true)) | $(@bind U₀ᶜᵒᵐᵖ PlutoUI.Slider(6:1:245, default=200, show_value=true)) |
"""

# ╔═╡ ffd3f7c6-e424-4d35-b711-b1e78bf565b0
if lang == "pt"
	aside((md"""
	!!! nota
		Neste exercício interativo, o estudante deverá ficar a perceber como ajustar a tensão de vazio do gerador para cada tipo de excitação, de modo que a respectiva característica externa passe no ponto de funcionamento escolhido. 
	"""), v_offset=-270)
elseif lang == "en"
	aside((md"""
	!!! note
		In this interactive exercise, the student should understand how to adjust the no-load voltage of the DC generator for each type of field circuit, in order to each external characteristic crosses the chosen operating point. 
	"""), v_offset=-270)
end

# ╔═╡ 2131ec25-bbcc-4fb4-abc7-c4d2aaf149cd
#= to check intermediate results
begin
	plot(Ifₛₕ, E₀ₛₕᵐᵃᵍ)
	plot!(Ifₛₕ, Uᶠ[:, 1:10:c], ylims=(0,300))
	plot!(Ifₛₕ, Rfₛₕ*Ifₛₕ)
	
end
=#

# ╔═╡ 65b12308-3fd2-4bc3-802f-f45d59c3dd0a
if lang == "pt"
	md"""
	### Cálculos auxiliares
	Nos 3 blocos de código `Julia` seguintes são efetuados os cálculos de engenharia para determinação das curvas características externas, apresentadas no gráfico anterior, relativas ao funcionamento do gerador CC nos modos de excitação: independente, derivação e composta aditiva. 
	> Não necessita de preocupar-se em perceber esta secção em detalhe!
	"""
elseif lang == "en"
	md"""
	### Auxiliary calculations
	In the next 3 `Julia` code snippets, the engineering calculations are carried out to determine the external characteristic curves, shown in the previous graph, related to the DC generator operation in the field circuit modes: independent, shunt and cumulative compound.
	> No need to worry about understanding this section in detail!
	"""
end

# ╔═╡ 5b9a8efb-8068-44b9-aa6f-3979907e8838
begin
	# Independent generator load characteristic
	Iₐᵢₙ = 0:1:2*Iₐᴳ;
	E₀ᵢₙ = U₀ᵢₙ
	Uᵢₙ = E₀ᵢₙ .- Rₐ*Iₐᵢₙ
end;

# ╔═╡ 57693454-2ec0-43ff-a6ca-b7c10b92d121
begin
	# Shunt generator load characteristic
	Iₐₛₕ = 0:0.1:8*Iₐᴳ 			# Armature current range
	
	j = 0.0001
	Ifₛₕ = 0:j:maximum(i) 		# Field current range
	E₀ₛₕᵐᵃᵍ = E_i.(Ifₛₕ)  		# Interpolation of FEM to a field current value
	
	Ifₛₕ₀ = i_E(U₀ₛₕ) 			# Interpolation of field current to U₀ value
	Rfₛₕ = U₀ₛₕ / Ifₛₕ₀ 

	ΔUₜₛₕᶠ = E₀ₛₕᵐᵃᵍ - Rfₛₕ * Ifₛₕ 		#ΔUₜ(Id) = E₀(Id) - Rexc * Id
	
	ΔUₜₛₕᶠ = ΔUₜₛₕᶠ[ΔUₜₛₕᶠ .>= 0] 		# selection of positive values of ΔUₜ(Id)

	# interpolation of I (load values) at ΔUₜ(I) curve, for the achieved ΔUₜ(Id) values
	Ishunt = Spline1D(Rₐ*Iₐₛₕ, Iₐₛₕ)
	I_shunt = Ishunt(ΔUₜₛₕᶠ)
	
	ii = count(i->(i>= 0), ΔUₜₛₕᶠ)
	if_ii = 0:j:((ii-1)*j)
	Uₛₕ = Rfₛₕ*if_ii
	
	#check output results:
	I_shunt, Uₛₕ
end;

# ╔═╡ 80ccbb97-53d2-42fb-8c83-f8502149698c
begin
	#= 
	Cumulative compound generator load characteristic:
	- a long shunt circuit was chosen;
	- with extra rheostat for series flux adjust -> simplified with Is=Ia/3 (series inductor is to strong...)
	=#
	Iₐᶜᵒᵐᵖ = 0:1:2*Iₐᴳ
	c=length(Iₐᶜᵒᵐᵖ)
	l=length(Ifₛₕ)
	
	If₀ = i_E(U₀ᶜᵒᵐᵖ) 				# no-load field current
	Rfₛₕᶜᵒᵐᵖ = U₀ᶜᵒᵐᵖ / If₀ 		# total field resistance
	
	ΔUᶠ = (Rₐ + Rₛ/3) * Iₐᶜᵒᵐᵖ 		# armature voltage drop
 	Ifʼ = α * Iₐᶜᵒᵐᵖ/3      		# series current seeing by Nf inductor

	# Parallel compound generator field lines in a type of: matrix[l,c]
	Uᶠ = Rfₛₕᶜᵒᵐᵖ.*(Ifₛₕ[1:l].-Ifʼ[1:c]').+ ΔUᶠ[1:c]'
	
	# Prepare interseption between FEM and parallel compound generator field lines
	func = abs.(E₀ₛₕᵐᵃᵍ.-Uᶠ) 	
	
	zeros_func=findmin(func, dims=1)		# find interseptions
	cartesian=getindex(zeros_func, 2)		# get data
	index=getindex.(cartesian, (2, 1))		# separate data
	indexf=index[2,:] 						# get field current index of interseptions

	Iexₜ=indexf*j 				# field current representing total magnetic flux
	Ifₗ=Iexₜ-Ifʼ 				# field current values at different loads
	Uᶜᵒᵐᵖ=Rfₛₕᶜᵒᵐᵖ*Ifₗ          # load voltages
	
	#check results:
	U₀ᶜᵒᵐᵖ, If₀, Rfₛₕᶜᵒᵐᵖ, Uᶠ
	#Iₐᶜᵒᵐᵖ, Uᶜᵒᵐᵖ, (c, l), Uᶠ, indexx, indexf, Iexₜ, Ifₗ
end;

# ╔═╡ 5c87ea9f-d46f-46a2-8e7e-52eed1f273ea
begin
	plot([In], seriestype=:vline, linestyle=:dash, lc=:red, label=:none, xlabel="I (A)")
	plot!([Un], seriestype=:hline, linestyle=:dash, lc=:red, label="(In, Un) rated values", ylabel="U (V)")
	
	plot!(Iₐᵢₙ, Uᵢₙ, lc=:blue, lw=2, label="Independent",  
			xlims=(0,2*Iₐᴳ), ylims=(0,300))

	plot!(I_shunt, Uₛₕ, lc=:green, lw=2, label="Shunt")

	plot!(Iₐᶜᵒᵐᵖ, Uᶜᵒᵐᵖ, lc=:black, lw=2, label="Compound⁺")
end

# ╔═╡ 57f9654d-4d98-4429-9661-cb6e52b58b4e


# ╔═╡ 3d7cfce7-f135-4211-b34a-db348034d062
if lang == "pt"
	md"""
	## d) Tipo de enrolamento induzido para correntes elevadas
	"""
elseif lang == "en"
	md"""
	## d) Armature winding type for high currents
	"""
end

# ╔═╡ 616c9118-1e07-41d0-919a-9ad289c546a6
if lang == "pt"
	md"""
	**Que tipo de enrolamento é selecionado para o induzido, quando se pretende que a máquina de corrente contínua suporte corrente elevadas? Justifique;**
	"""
elseif lang == "en"
	md"""
	**What type of winding is selected for the armature, when the direct current machine is intended to withstand high currents? Justify;**
	"""
end

# ╔═╡ de9086cc-4e8e-4fcc-973c-1aaa92cba3f4
if lang == "pt"
	md"""
	O enrolamento induzido do tipo **imbricado** permite obter vários caminhos em paralelo (igual ao número de polos), nos quais a corrente se divide, permitindo assim suportar correntes elevadas, contudo a tensão resultante é baixa.

	> Bibliografia diversa para leitura sobre os enrolamentos do induzido imbricado/ondulado:
	>- Secção 5.3 de [^Guru2001];
	>- Secção 4.2.3 de [^Sen1989];
	>- Secção 6-3 de [^Matsch1987];
	>- Secção 8.3 de [^Chapman2005];
	>- Secção 4.2-10 de [^Sahdev2018].
	"""
elseif lang == "en"
	md"""
	The **lap** armature winding type allows to obtain several parallel paths  (equal to the poles number), in which the current is divided, thus allowing it to withstand high currents, however the resulting voltage is low.

	> Diverse bibliography for reading on lap/wave armature windings:
	>- Section 5.3 of [^Guru2001];
	>- Section 4.2.3 of [^Sen1989];
	>- Section 6-3 of [^Matsch1987];
	>- Section 8.3 of [^Chapman2005];
	>- Section 4.2-10 of [^Sahdev2018].
	"""
end

# ╔═╡ 17f36e28-24b9-40fa-86fa-d896f035eaae


# ╔═╡ 1f863b7f-b47a-49a9-b524-5d4af55a6c11
if lang == "pt"
	md"""
	## e) Comutação/polos auxiliares
	"""
elseif lang == "en"
	md"""
	## e) Commutation/auxiliary poles
	"""
end

# ╔═╡ 649c95ce-6b90-4646-adbe-3aa0a106214e
if lang == "pt"
	md"""
	**O que são, onde são colocados e como atuam os polos auxiliares de uma máquina de corrente contínua? Como estão identificados na placa de terminais da máquina?**
	"""
elseif lang == "en"
	md"""
	**What are and where the auxiliary poles of a direct current machine are  placed? How do they work? How are they identified on the machine's terminal board?**
	"""
end

# ╔═╡ bb96846e-253b-4ce7-8dc8-ea0f7e03dfc9
if lang == "pt"
	md"""
	Os polos auxiliares, também designados por polos de comutação ou ainda por interpolos, tratam-se de pequenas peças polares com enrolamento auxiliar (ligado em série com o enrolamento induzido), que utiliza a corrente do induzido e servem para facilitar o processo de comutação, anulando a reação magnética do induzido, na zona da linha neutra geométrica. 
		
	Na placa de terminais da máquina, os interpolos estão identificados pelo par de terminais: $$\rm G-H$$.

	> Bibliografia diversa para leitura sobre reação magnética do induzido e métodos de mitigação:
	>- Secção 5.8 de [^Guru2001];
	>- Secção 4.3.5 de [^Sen1989];
	>- Secção 6-5.1 de [^Matsch1987];
	>- Secção 8.4 de [^Chapman2005];
	>- Secção 4.24 de [^Sahdev2018].
	"""
elseif lang == "en"
	md"""
	Auxiliary poles, also called commutating poles or interpoles, are small pole pieces with an auxiliary winding (connected in series with the armature winding), which uses the armature current and serve to facilitate the commutation process, cancel the armature reaction, around to the geometric neutral line.

	On the machine terminal board, the interpoles are identified by the terminal pair: $$\rm G-H$$.

	> Diverse bibliography for reading about the armature reaction and its mitigation methods:
	>- Section 5.8 of [^Guru2001];
	>- Section 4.3.5 of [^Sen1989];
	>- Section 6-5.1 of [^Matsch1987];
	>- Section 8.4 of [^Chapman2005];
	>- Section 4.24 of [^Sahdev2018].
	"""
end

# ╔═╡ ac29873b-755d-416a-8276-2e1ac5bb446a


# ╔═╡ ac1bc909-c6b0-497a-9c63-c1fccf7afa5c
md"""
# II - Motor
"""

# ╔═╡ 9312748a-e976-4e10-8492-84edee70d785
if lang == "pt"
	md"""
	## a) motor de excitação composta, $n$
	"""
elseif lang == "en"
	md"""
	## a) Compound motor, $n$
	"""
end

# ╔═╡ e786c743-2c26-4c8b-a271-3d23b6cfdebc
if lang == "pt"
	md"""
	**Determine a velocidade nas condições indicadas no esquema elétrico do motor;**
	"""
elseif lang == "en"
	md"""
	**Determine the speed under the conditions indicated on the motor electric scheme;**
	"""
end

# ╔═╡ bb1a1a49-fe8d-4d8a-aa84-2dc80d5af0a5
if lang == "pt"
	md"""
	O circuito de excitação derivação do motor CC apresenta os valores do reóstato de campo, $$R_{rh}^M$$ e do enrolamento de excitação, $$R_f$$, pelo que se pode determinar a corrente de excitação deste ramo, $$I_f^M$$:

	$$I_f^M=\frac{U^M}{R_f+R_{rh}^M}$$
	"""
elseif lang == "en"
	md"""
	The shunt excitation circuit of the DC motor presents the values of the field rheostat and the field winding, thus the field current of this branch can be achived:

	$$I_f^M=\frac{U^M}{R_f+R_{rh}^M}$$
	"""
end

# ╔═╡ 36694975-3d03-4cc3-a50e-4fb7cfc9695f
Ifᴹ = Uᴹ /(Rf + Rᵣₕᴹ)  			# A, DC motor shunt field current

# ╔═╡ 9105e60e-dd05-4ccd-8c7c-31768b41bf24
if lang == "pt"
	md"""
	O motor CC encontra-se ligado com excitação composta, em longa derivação, com fluxo série aditivo. Assim, para o cálculo do fluxo magnético total é necessário contabilizar também o contributo do enrolamento de excitação série. A corrente de excitação $$I_{ex}$$ representa a força magnetomotriz total dos polos de excitação e vem dada por:

	$$I_{ex}^M=I_f^M + \alpha I_a^M$$ onde:
		
	$$\alpha=\frac{N_s}{N_f}$$
	"""
elseif lang == "en"
	md"""
	The DC motor is connected with compound excitation, in long shunt, with cumulative/additive series flux. Thus, to calculate the total magnetic flux, it is also necessary to taking account, the contribution of the series excitation winding. The field current $$I_{ex}$$ represents the total magnetomotive force of the field poles and is given by:

	$$I_{ex}^M=I_f^M + \alpha I_a^M$$ 
		
	with:
		
	$$\alpha=\frac{N_s}{N_f}$$
	"""
end

# ╔═╡ 3a3138c4-380d-4f73-9872-cfa311972618
Iexᴹ = Ifᴹ + α * Iₐᴹ 		# A, DC motor total field current

# ╔═╡ 3bad44ae-3fef-4fee-bac8-3991155cdc86
if lang == "pt"
	md"""
	O valor da corrente de excitação calculado, $$I_{ex}^M$$, é agora utilizado para verificar qual a FEM correspondente na característica magnética e assim determinar-se o valor do fluxo magnético, representado por $$k\phi_0^M$$:
	"""
elseif lang == "en"
	md"""
	The value of the calculated field current, $$I_{ex}^M$$, is now used to verify the corresponding EMF in the magnetic characteristic and thus to determine the value of the magnetic flux, represented by $$k\phi_0^ M$$:
	"""
end

# ╔═╡ 00b51733-1a4b-4c2b-8cf9-52dae8cd0026
begin
	E₀ᵐᵃᵍᴹ = E_i(Iexᴹ)			# V, EMF from magnetic characteristic
	kϕ₀ᴹ = E₀ᵐᵃᵍᴹ / n_mag  		# V/rpm, related magnetic flux
	E₀ᵐᵃᵍᴹ, kϕ₀ᴹ
end

# ╔═╡ a3066a61-48e9-489e-8876-b4917dc5b9c9
if lang == "pt"
	md"""
	Assim, têm-se os dados para determinar a velocidade do motor CC através da expressão genérica:

	$$n=\frac{U-(R_a+R_s)I_a+\Delta E}{k\phi_0}$$
	"""
elseif lang == "en"
	md"""
	Thus, we have the data to determine the DC motor speed through the generic expression:

	$$n=\frac{U-(R_a+R_s)I_a+\Delta E}{k\phi_0}$$
	"""
end

# ╔═╡ ba4f74cb-0aed-46b6-b997-245cda624df9
begin
	nᴹ = (Uᴹ - (Rₐ+Rₛ)*Iₐᴹ + ΔE)/kϕ₀ᴹ   		# rpm, DC motor speed
	nᴹ = round(Int, nᴹ) 						# rpm, speed rounded to unit
end

# ╔═╡ 8e446ce3-f1d5-433e-a9be-71d5c430e824


# ╔═╡ d18d3643-1785-42fd-a0e0-0f7d147b1a61
if lang == "pt"
	md"""
	## b) Motor série, $I$
	"""
elseif lang == "en"
	md"""
	## b) Series motor, $I$
	"""
end

# ╔═╡ bdeaa35b-0ce1-465e-a5bd-d0e7e717e135
if lang == "pt"
	md"""
	**Considere que desliga no circuito do motor, o ramo de excitação em derivação.**

	**Determine a corrente consumida quando o motor série fornece uma potência útil de 27.5kW (binário motor e velocidade são desconhecidos). Despreze a reação magnética do induzido;**
		"""
elseif lang == "en"
	md"""
	**Consider that the shunt field branch is turned off in the motor circuit.**

	**Determine the current consumed when the series motor supplies a mechanical power of 27.5kW (motor torque and speed are unknown). Neglect the armature magnetic reaction**
	"""
end

# ╔═╡ ccaee162-7027-4787-98a2-3515cbdee0ff
Pᵤᴹˢ = 27.5e3

# ╔═╡ 2bb73740-feb1-434c-8fc1-aeb269fa39d0
if lang == "pt"
	md"""
	A potência desenvolvida d e um motor CC é dada por:
		
	$$P_d=P_u+P_{rot}$$
	"""
elseif lang == "en"
	md"""
	The developed power of a DC motor is given by:

	$$P_d=P_u+P_{rot}$$
	"""
end

# ╔═╡ def42fc9-c9df-4abe-9494-0353bf08d643
Pdᴹˢ = Pᵤᴹˢ + pᵣₒₜ

# ╔═╡ 6ca44365-eed7-42da-a2cf-c8544e7b1a9f
if lang == "pt"
	md"""
	Por outro lado, a potência desenvolvida e um motor CC é dada por:
		
	$$P_d=E' I_a$$

	No caso do motor série, a força contraeletromotriz (FCEM) vem dada por:
		
	$$E'=U-(R_a+R_s)I$$

	Juntando as duas expressões tém-se:

	$$P_d=U I - (R_a+R_s)I^2$$ com $$I_a=I$$, tratando-se de um motor série.

	Encontrando a raíz apropriada do polinómio anterior, obtém-se a corrente:
	"""
elseif lang == "en"
	md"""
	On the other hand, the developed power of a DC motor is given by:

	$$P_d=E' I_a$$

	In the case of the series motor, the  back electromotive force (back-EMF) is given by:

	$$E'=U-(R_a+R_s)I$$

	Combining the two expressions, we have:

	$$P_d=U I - (R_a+R_s)I^2$$ with $$I_a=I$$, in the case of a series motor.

	Finding the appropriate root of the previous polynomial, we obtain the current:
	"""
end

# ╔═╡ 0bed098b-367e-4476-a3f4-d4ccf4cda029
begin
	f(Iₛ) = (Uᴹ - (Rₐ+Rₛ)*Iₛ)*Iₛ - Pdᴹˢ  		# f(Iₛ): polynomial function
	
	# find_zero,  function of Roots.jl package to find  f(x)=0:
	Iₛᴹˢ = find_zero(f, [0, 10*Iₐᴹ])
	Iₛᴹˢ = round(Iₛᴹˢ, digits=1)
end

# ╔═╡ 0cf3f838-1c91-4ee2-8967-ec804bc41e8c


# ╔═╡ 4b360926-b2c4-4efd-89ca-d02fa170a37e
if lang == "pt"
	md"""
	## c) Motor série, $T_d$
	"""
elseif lang == "en"
	md"""
	## c) Series motor, $T_d$
	"""
end

# ╔═╡ acbb3a77-8858-4aa8-b6bb-477246c24fa7
if lang == "pt"
	md"""
	**Calcule o binário desenvolvido nas condições da alínea anterior;**
	"""
elseif lang == "en"
	md"""
	**Calculate the developed torque, under the conditions of the previous question;**
	"""
end

# ╔═╡ 5aedf07a-4cba-4416-8b0f-29aad1c4a563
if lang == "pt"
	md"""
	O binário desenvolvido, $$T_d$$, depende do fluxo magnético e da corrente do induzido. No caso do motor série a corrente do induzido é também a corrente de excitação, se não for considerado um reóstato de campo.
	
	Como a característica magnética é baseada na corrente de campo do enrolamento $$\rm C-D$$, como se percebe pelos baixos valores da corrente de excitação, é necessário através da razão de equivalência, $$\alpha$$, representar a mesma força magnetomotriz produzida pelo enrolamento $$\rm E-F$$:

	$$I_{ex}^{MS}=I_f^M + \alpha I_a^{MS}$$
	"""
elseif lang == "en"
	md"""
	The developed torque, $$T_d$$, depends on the magnetic flux and the armature current. In the case of a series motor, the armature current is also the field current, if a field rheostat is not considered.

	As the magnetic characteristic is based on the $$\rm C-D$$ winding field current, as can be seen from the low excitation current values, it is necessary through the equivalence ratio, $$\alpha$$, to represent the same magnetomotive force  produced by the $$\rm E-F$$ winding:

	$$I_{ex}^{MS}=\alpha I_a^{MS}$$ 
	"""
end

# ╔═╡ b25e57bb-4569-4ef8-a2a2-ca056e008a94
begin
	Iexᴹˢ = α * Iₛᴹˢ  					# A, field current related to C-D field winding
	Iexᴹˢ = round(Iexᴹˢ, digits=3)
end

# ╔═╡ 86a2e35e-566f-4c78-949c-5c8102965133
if lang == "pt"
	md"""
	Com a corrente de excitação, $$I_{ex}^{MS}$$, obtêm-se a FEM e o valor relativo ao fluxo magnético, $$k\phi_0^{MS}$$:
	"""
elseif lang == "en"
	md"""
	With the field current, $$I_{ex}^{MS}$$, the values of EMF and the related magnetic flux, $$k\phi_0^{MS}$$, are obtained:
	"""
end

# ╔═╡ 8045db09-25b9-44a2-ab83-ca08a96cf1c8
begin
	E₀ᵐᵃᵍᴹˢ = E_i(Iexᴹˢ)				# V, EMF from magnetic characteristic
	kϕ₀ᴹˢ = E₀ᵐᵃᵍᴹˢ / n_mag 			# V/rpm, related magnetic flux
	E₀ᵐᵃᵍᴹˢ, kϕ₀ᴹˢ
end

# ╔═╡ 02a29e79-9067-4d0b-b9fd-7f1e43cb4045
begin
	Td = kϕ₀ᴹˢ * (60/2π) * Iₛᴹˢ 		# Nm, developed torque
	Td = round(Int, Td)
end;

# ╔═╡ 44effeaa-2765-4249-9f70-dd2036d4c9a2
if lang == "pt"
	md"""
	Assim, obtém-se um binário desenvolvido, $$T_d=$$ $Td $$\rm Nm$$.
	"""
elseif lang == "en"
	md"""
	Thus, a developed torque, $$T_d=$$ $Td $$\rm Nm$$ is obtained.
	"""
end

# ╔═╡ 8bdc891f-07d7-4c9a-93c6-93f774f4ce4c


# ╔═╡ f204f664-f4f0-418b-a798-898ab22ac4d9
if lang == "pt"
	md"""
	## d) Embalamento
	"""
elseif lang == "en"
	md"""
	## d) Overspeed
	"""
end

# ╔═╡ 7469aeed-9f3a-4833-a4c5-4c71a0395fe8
if lang == "pt"
	md"""
	**Em que situações pode um motor de corrente contínua embalar?**

	**Justifique e apresente duas situações concretas;**
	"""
elseif lang == "en"
	md"""
	**In what situations can a DC motor overspeed?**

	**Justify and present two specific situations.**
	"""
end

# ╔═╡ df15da50-053b-47f9-8c61-57d6b0c267cc
if lang == "pt"
	md"""
	Como regra geral, um motor de corrente contínua pode embalar sempre que o fluxo magnético se torne muito reduzido, pois a velocidade é inversamente proporcional ao valor do fluxo magnético.
		
	Situações em que o embalamento do motor pode ocorrer:
	- um motor série ficar em vazio, ou com carga muito reduzida;
	- um motor de excitação composta de fluxo subtrativo com carga excessiva;
	- perda acidental do circuito de excitação nos motores de excitação: independente, derivação e composta (quando em vazio).
	"""
elseif lang == "en"
	md"""
	As a rule of thumb, a direct current motor may  overspeed whenever the magnetic flux becomes too low, as the speed is inversely proportional to the value of the magnetic flux.

	Situations in which a motor overspeed can occur:
	- a series motor loose the load, or went to a very low load;
	- a differential compound motor with excessive load;
	- accidental loss of the field circuit in the motors: independent, shunt and compound (when at no-load).
	"""
end

# ╔═╡ fdab8c81-ab77-4db1-b1d4-922a6283c244


# ╔═╡ 8b956ee7-4c85-4b6b-ad08-d086224dcd8c
md"""
## e) 💻 $$R_{fsx}  \updownarrow \:\:\: \Rightarrow \:\: T_d=f(I)$$
"""

# ╔═╡ 16cbb122-d4fe-4fea-8799-20aef78b5a2f
if lang == "pt"
	md"""
	**Apresente qualitativamente a característica de binário desenvolvido de um motor série.**

	**Justifique a sua forma e explicite, também qualitativamente, a influência de um reóstato de campo sobre essa característica**
	"""
elseif lang == "en"
	md"""
	**Qualitatively, present the developed torque characteristic of a series motor.**

	**Justify its shape and explain, also qualitatively, the influence of a field rheostat on this characteristic.**
	"""
end

# ╔═╡ f85a8b72-2f94-4692-a763-98b9457837f5
if lang == "pt"
	md"""
	> Para a resolução desta questão optou-se pelo desenvolvimento de uma solução quantitativa, determinando computacionalmente a solução numérica da característica de binário, tirando partido da linguagem de programação científica `Julia` e do ambiente interativo do *notebook* `Pluto.jl`.
	"""
elseif lang == "en"
	md"""
	> To solve this question, a quantitative solution was developed, computationally determining the numerical solution of torque characteristic, taking advantage of the scientific programming language `Julia` and the interactive *notebook* environment `Pluto.jl`.
	"""
end

# ╔═╡ ef49d52d-83a2-4f5e-8b84-efd15e94f935
md"""
Field rheostat of series motor, Ω: $(@bind Rfₛₓ PlutoUI.Slider(0.0001:0.0001:0.026, default=0.026, show_value=true))
"""

# ╔═╡ 2b61faee-5b76-43b4-ae84-2da98b8c735e
if lang == "pt"
	aside((md"""
	!!! nota
		Neste exercício interativo, o estudante deverá conseguir justificar a influência de um reóstato de campo sobre essa característica de binário de um motor série. 
	"""), v_offset=-240)
elseif lang == "en"
	aside((md"""
	!!! note
		In this interactive exercise, the student should be able to justify the influence of a field rheostat on the torque characteristic of a series motor. 
	"""), v_offset=-240)
end

# ╔═╡ b7f80612-1ee1-435e-9665-4c19158e2638
if lang == "pt"
	md"""
	### Cálculos auxiliares
	Nos 2 blocos de código `Julia` seguintes são efetuados os cálculos de engenharia para determinação da característica de binário do motor série, considerando a influência de um reóstato de excitação ligado em paralelo com o enrolamento de campo.
	"""
elseif lang == "en"
	md"""
	### Auxiliary calculations
	In the next 2 `Julia` code snippets, the engineering calculations are carried out to determine the torque characteristic of the series motor, considering the influence of a field rheostat connected in parallel with the field winding.
	"""
end

# ╔═╡ e5e7d63b-67a0-48df-b959-34b0ac7f37c6
begin
	I=0:1:1.5*Iₐᴹ 					# A, current range of series motor
	Ifs= I.* Rfₛₓ / (Rₛ+Rfₛₓ)		# A, field current values
	Iexₛₓᴹˢ= α .* Ifs 				# A, related field currents on magnetic characteristic
	E₀ᵐᵃᵍˢˣ = E_i.(Iexₛₓᴹˢ)			# V, EMF
	kϕ₀ₛₓᴹˢ = E₀ᵐᵃᵍˢˣ / n_mag 		# V/rpm, related magnetic flux
end;

# ╔═╡ 6acc88e7-31ff-48f6-9fb9-67201bcef3a7
Tdᴹˢ = kϕ₀ₛₓᴹˢ .* (60/2π) .* I; 	# Nm, developed torque values

# ╔═╡ d6e80de4-985a-4d43-8f3c-1fd0ea8f6274
plot(I, Tdᴹˢ, 
		xlims=(0,1.5*Iₐᴹ), ylims=(0,400), 
		title="Torque characteristic", label=false,
		ylabel="Developed torque, Nm", xlabel="Armature current, A")

# ╔═╡ 7af2b085-c36c-4469-b852-15b04396e95a
if lang == "pt"
	md"""
	---
	# Bibliografia
	"""
elseif lang == "en"
	md"""
	---
	# Bibliography
	"""
end

# ╔═╡ 1c125ce3-4345-4b5d-bf7b-c580b09f5613
md"""
[^Guru2001]: B. S. Guru, H. R. Hiziroğlu, Electric Machinery and Transformers, Oxford University Press, 2001.

[^Sen1989]: P. C. Sen, Principles of electric machines and power electronics, John Wiley & Sons, 1989.

[^Matsch1987]: L. W. Matsch, J. D. Morgan, Electromagnetic and Electromechanical Machines, John Wiley & Sons, 1987.

[^Chapman2005]: S. J. Chapman, Electric Machinery Fundamentals, McGraw Hill, 2005.

[^Sahdev2018]: S. K. Sahdev, Electrical Machines, Cambridge University Press, 2018.
"""

# ╔═╡ 0e383a89-f6c9-4871-9745-1bd7f72fb756
md"""
---
`ISEL/DEEEA/GDME/Máquinas Elétricas 2`
"""


# ╔═╡ 080a827e-c525-4fb3-a81e-b1758949e18e
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

# ╔═╡ 08a6b27b-8aa2-4225-8f9b-576d8333c3d2
md"""
# *Notebook*
"""

# ╔═╡ 3c84a0d4-8eeb-4feb-8276-4d62ed7492f5
if lang == "pt"
	md"""
	Documentação das bibliotecas `Julia` utilizadas: [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [EasyFit.jl](https://github.com/m3g/EasyFit.jl), [Roots](https://juliamath.github.io/Roots.jl/stable/), [Dierckx](https://github.com/kbarbary/Dierckx.jl).
	"""
elseif lang == "en"
	md"""
	`Julia` packages documentation: [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [EasyFit.jl](https://github.com/m3g/EasyFit.jl), [Roots](https://juliamath.github.io/Roots.jl/stable/), [Dierckx](https://github.com/kbarbary/Dierckx.jl.
	"""
end

# ╔═╡ 3a2663dc-9474-44b1-b9f8-13cae96c42bf
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

# ╔═╡ 205b547e-731d-4049-9120-0400a84b2ea0
if lang == "pt"
	TableOfContents(title="Índice")
elseif lang == "en"
	TableOfContents()
end

# ╔═╡ ea4b7a97-89da-478c-916d-5a497f03c120
if lang == "pt"
	aside((md"""
	!!! info
		No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
	"""), v_offset=-120)
elseif lang == "en"
	aside((md"""
	!!! info
		In the table of contents of this notebook, topics marked with "💻" require student participation.
	"""), v_offset=-120)
end

# ╔═╡ 68d4acc1-7588-4a29-8a73-81ac21848568
md"""
|  |  |
|:--:|:--|
|  | This notebook, [Test.DCmachines.jl](https://ricardo-luis.github.io/me-2/Test.DCmachines.html), is part of the collection "[_Notebooks_ Reativos de Apoio a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dierckx = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
EasyFit = "fde71243-0cda-4261-b7c7-4845bd106b21"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Roots = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"

[compat]
Dierckx = "~0.5.4"
EasyFit = "~0.6.10"
Plots = "~1.40.17"
PlutoTeachingTools = "~0.4.4"
PlutoUI = "~0.7.69"
Roots = "~2.0.22"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "5b32bd10aa6ac2596b7d5387b6d1a416572f2e9b"

[[deps.ADTypes]]
git-tree-sha1 = "7927b9af540ee964cc5d1b73293f1eb0b761a3a1"
uuid = "47edcb42-4c32-4615-8424-f2b9edc5f35b"
version = "1.16.0"

    [deps.ADTypes.extensions]
    ADTypesChainRulesCoreExt = "ChainRulesCore"
    ADTypesConstructionBaseExt = "ConstructionBase"
    ADTypesEnzymeCoreExt = "EnzymeCore"

    [deps.ADTypes.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "f7817e2e585aa6d924fd714df1e2a84be7896c60"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.3.0"

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

    [deps.Adapt.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "9606d7832795cbef89e06a550475be300364a8aa"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.19.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
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

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "06ee8d1aa558d2833aa799f6f0b31b30cada405f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.2"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

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
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

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

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
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
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "76b3b7c3925d943edf158ddb7f693ba54eb297a5"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.0"

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

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.DifferentiationInterface]]
deps = ["ADTypes", "LinearAlgebra"]
git-tree-sha1 = "54d7b8c74408048aea9c055ac8573b2b5c5ec11f"
uuid = "a0c0ee7d-e4b9-4e03-894e-1c5f64a51d63"
version = "0.7.4"

    [deps.DifferentiationInterface.extensions]
    DifferentiationInterfaceChainRulesCoreExt = "ChainRulesCore"
    DifferentiationInterfaceDiffractorExt = "Diffractor"
    DifferentiationInterfaceEnzymeExt = ["EnzymeCore", "Enzyme"]
    DifferentiationInterfaceFastDifferentiationExt = "FastDifferentiation"
    DifferentiationInterfaceFiniteDiffExt = "FiniteDiff"
    DifferentiationInterfaceFiniteDifferencesExt = "FiniteDifferences"
    DifferentiationInterfaceForwardDiffExt = ["ForwardDiff", "DiffResults"]
    DifferentiationInterfaceGPUArraysCoreExt = "GPUArraysCore"
    DifferentiationInterfaceGTPSAExt = "GTPSA"
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
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "3e6d038b77f22791b8e3472b7c633acea1ecac06"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.120"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EasyFit]]
deps = ["LsqFit", "Parameters", "Statistics", "TestItems", "Unitful"]
git-tree-sha1 = "db5d8290bd46c9582782b4a29eaf155deb7c9fcc"
uuid = "fde71243-0cda-4261-b7c7-4845bd106b21"
version = "0.6.10"

    [deps.EasyFit.extensions]
    SplineFitExt = "Interpolations"

    [deps.EasyFit.weakdeps]
    Interpolations = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"

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

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Setfield"]
git-tree-sha1 = "f089ab1f834470c525562030c8cfde4025d5e915"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.27.0"

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

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "a2df1b776752e3f344e5116c06d75a10436ab853"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.38"

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

    [deps.ForwardDiff.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

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

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "68c173f4f449de5b438ee67ed0c9c748dc31a2ec"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.28"

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

[[deps.LsqFit]]
deps = ["Distributions", "ForwardDiff", "LinearAlgebra", "NLSolversBase", "Printf", "StatsAPI"]
git-tree-sha1 = "f386224fa41af0c27f45e2f9a8f323e538143b43"
uuid = "2fda8390-95c7-5789-9bda-21331edee243"
version = "0.15.1"

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

[[deps.NLSolversBase]]
deps = ["ADTypes", "DifferentiationInterface", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "25a6638571a902ecfb1ae2a18fc1575f86b1d4df"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.10.0"

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

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

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

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "f07c06228a1c670ae4c87d1276b92c7c597fdda0"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.35"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "275a9a6d85dc86c24d03d1837a0010226a96f540"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.3+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

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

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9da16da70037ba9d701192e27befedefb91ec284"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.2"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

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

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.Roots]]
deps = ["ChainRulesCore", "CommonSolve", "Printf", "Setfield"]
git-tree-sha1 = "0f1d92463a020321983d04c110f476c274bafe2e"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "2.0.22"

    [deps.Roots.extensions]
    RootsForwardDiffExt = "ForwardDiff"
    RootsIntervalRootFindingExt = "IntervalRootFinding"
    RootsSymPyExt = "SymPy"
    RootsSymPyPythonCallExt = "SymPyPythonCall"

    [deps.Roots.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    IntervalRootFinding = "d2bf35a9-74e0-55ec-b149-d360ff49b807"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
    SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"

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

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

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

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "41852b8679f78c8d8961eeadc8f62cef861a52e3"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.1"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

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

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "8e45cecc66f3b42633b8ce14d431e8e57a3e242e"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.5.0"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

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

[[deps.TestItems]]
git-tree-sha1 = "42fd9023fef18b9b78c8343a4e2f3813ffbcefcb"
uuid = "1c621080-faea-4a02-84b6-bbd5e436b8fe"
version = "1.0.0"

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

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
# ╟─9b9d7372-f136-499a-a900-e999a2a6784e
# ╟─ea3e2579-177a-477f-97f6-71ebe0f014cd
# ╟─0823bba0-4ee5-41b4-bf9c-f1914fdbc7a3
# ╟─7ca9e6c8-5e20-4215-a2eb-97798306a060
# ╟─0257581c-670d-437d-9d9d-c1620c5a60c1
# ╟─1e9ffcd8-aaab-4387-a60e-930deaf1f24a
# ╠═616efd77-a81e-4242-9110-cb73b7953497
# ╟─1ceaa326-46f1-4dba-8288-2d06345ca41d
# ╠═929cbbe0-5167-11ed-22ad-3d923623a1e8
# ╟─b64be4f2-d16c-4d40-8437-4bad945cff01
# ╟─a6ff8b62-6fd0-45ff-8453-2c5b0a630219
# ╠═62df9520-f4b6-41e5-a75f-8ad257ef3529
# ╟─016d56be-2d99-4a20-9908-a4fb7c347af0
# ╟─7d2b527d-da2b-4704-a931-3cc06d5a5215
# ╟─4153a634-6797-449f-8c5b-25355b6a5507
# ╟─fc2bd53a-7d0c-4ca8-adef-ddf7b700954b
# ╟─b2792a51-9371-4406-9224-ba96588827c7
# ╠═54ccccd5-a2ce-42cf-85c5-8640fa0afcb4
# ╟─42335ad4-de0a-4ebd-9c2a-729c4a23cf7d
# ╠═eb2b2d53-f1b3-4798-b2fc-ba42b2914826
# ╟─da08e82c-f364-4102-9648-cf400cea0578
# ╠═a5964481-bfc3-429a-94af-6eac8d7335b2
# ╟─9e81564f-a752-4fcf-8309-aedbf46e3d21
# ╠═e4cba508-69ed-4c0d-b3d8-85cd67b375e0
# ╟─cd05b997-f3ec-4e7f-a590-75fb3f8c5eca
# ╟─99718cff-350e-4614-a9bc-b8995e5c1024
# ╟─c115c741-514d-4237-8c92-c9a7e51dbec0
# ╟─b794ec89-73ba-4543-86db-47b930ba2cd2
# ╠═12461786-f362-4f7b-9f1c-1ea0b6256947
# ╠═39917674-e6ad-405f-bc66-1d37437b4fda
# ╠═a0a91e9b-0816-45ca-b46e-da7206406352
# ╠═93b2bdb6-0c50-459f-8a05-5b9f94276b17
# ╠═9f8bb91a-685f-4f3b-9826-2aa05c7fbe16
# ╟─0cd99825-9f0f-420e-904f-412ca8f88660
# ╠═1fcd9e30-cd4e-4aff-b52d-0d4a84c34d9d
# ╟─6c53cb0f-ed8c-44b8-a989-20f7681c4596
# ╠═765f1a81-ed15-48a2-b2a5-184410410736
# ╟─013705ab-87fc-4cf8-a523-a4dd412a06ff
# ╟─2b3f8456-6b70-4b7f-997c-a7d94db46c6b
# ╟─0a6f6c04-7856-495f-ac62-09c865e60472
# ╟─e0b9823e-1e98-4b87-a96f-c9472806f957
# ╟─e645b64d-c6a3-48b0-8ed0-5525bef418e1
# ╟─acd3ce49-2f6b-42a2-ba90-03c46f539fb7
# ╟─afee0704-03a6-4403-afe0-56b5a4a1df40
# ╟─cd5aeeee-5ab6-4589-a6e7-25fb6115b283
# ╟─5c87ea9f-d46f-46a2-8e7e-52eed1f273ea
# ╟─ffd3f7c6-e424-4d35-b711-b1e78bf565b0
# ╟─2131ec25-bbcc-4fb4-abc7-c4d2aaf149cd
# ╟─65b12308-3fd2-4bc3-802f-f45d59c3dd0a
# ╠═5b9a8efb-8068-44b9-aa6f-3979907e8838
# ╠═57693454-2ec0-43ff-a6ca-b7c10b92d121
# ╠═80ccbb97-53d2-42fb-8c83-f8502149698c
# ╟─57f9654d-4d98-4429-9661-cb6e52b58b4e
# ╟─3d7cfce7-f135-4211-b34a-db348034d062
# ╟─616c9118-1e07-41d0-919a-9ad289c546a6
# ╟─de9086cc-4e8e-4fcc-973c-1aaa92cba3f4
# ╟─17f36e28-24b9-40fa-86fa-d896f035eaae
# ╟─1f863b7f-b47a-49a9-b524-5d4af55a6c11
# ╟─649c95ce-6b90-4646-adbe-3aa0a106214e
# ╟─bb96846e-253b-4ce7-8dc8-ea0f7e03dfc9
# ╟─ac29873b-755d-416a-8276-2e1ac5bb446a
# ╟─ac1bc909-c6b0-497a-9c63-c1fccf7afa5c
# ╟─9312748a-e976-4e10-8492-84edee70d785
# ╟─e786c743-2c26-4c8b-a271-3d23b6cfdebc
# ╟─bb1a1a49-fe8d-4d8a-aa84-2dc80d5af0a5
# ╠═36694975-3d03-4cc3-a50e-4fb7cfc9695f
# ╟─9105e60e-dd05-4ccd-8c7c-31768b41bf24
# ╠═3a3138c4-380d-4f73-9872-cfa311972618
# ╟─3bad44ae-3fef-4fee-bac8-3991155cdc86
# ╠═00b51733-1a4b-4c2b-8cf9-52dae8cd0026
# ╟─a3066a61-48e9-489e-8876-b4917dc5b9c9
# ╠═ba4f74cb-0aed-46b6-b997-245cda624df9
# ╟─8e446ce3-f1d5-433e-a9be-71d5c430e824
# ╟─d18d3643-1785-42fd-a0e0-0f7d147b1a61
# ╟─bdeaa35b-0ce1-465e-a5bd-d0e7e717e135
# ╠═ccaee162-7027-4787-98a2-3515cbdee0ff
# ╟─2bb73740-feb1-434c-8fc1-aeb269fa39d0
# ╠═def42fc9-c9df-4abe-9494-0353bf08d643
# ╟─6ca44365-eed7-42da-a2cf-c8544e7b1a9f
# ╠═0bed098b-367e-4476-a3f4-d4ccf4cda029
# ╟─0cf3f838-1c91-4ee2-8967-ec804bc41e8c
# ╟─4b360926-b2c4-4efd-89ca-d02fa170a37e
# ╟─acbb3a77-8858-4aa8-b6bb-477246c24fa7
# ╟─5aedf07a-4cba-4416-8b0f-29aad1c4a563
# ╠═b25e57bb-4569-4ef8-a2a2-ca056e008a94
# ╟─86a2e35e-566f-4c78-949c-5c8102965133
# ╠═8045db09-25b9-44a2-ab83-ca08a96cf1c8
# ╟─44effeaa-2765-4249-9f70-dd2036d4c9a2
# ╠═02a29e79-9067-4d0b-b9fd-7f1e43cb4045
# ╟─8bdc891f-07d7-4c9a-93c6-93f774f4ce4c
# ╟─f204f664-f4f0-418b-a798-898ab22ac4d9
# ╟─7469aeed-9f3a-4833-a4c5-4c71a0395fe8
# ╟─df15da50-053b-47f9-8c61-57d6b0c267cc
# ╟─fdab8c81-ab77-4db1-b1d4-922a6283c244
# ╟─8b956ee7-4c85-4b6b-ad08-d086224dcd8c
# ╟─16cbb122-d4fe-4fea-8799-20aef78b5a2f
# ╟─f85a8b72-2f94-4692-a763-98b9457837f5
# ╟─ef49d52d-83a2-4f5e-8b84-efd15e94f935
# ╟─d6e80de4-985a-4d43-8f3c-1fd0ea8f6274
# ╟─2b61faee-5b76-43b4-ae84-2da98b8c735e
# ╟─b7f80612-1ee1-435e-9665-4c19158e2638
# ╠═e5e7d63b-67a0-48df-b959-34b0ac7f37c6
# ╠═6acc88e7-31ff-48f6-9fb9-67201bcef3a7
# ╟─7af2b085-c36c-4469-b852-15b04396e95a
# ╟─1c125ce3-4345-4b5d-bf7b-c580b09f5613
# ╟─0e383a89-f6c9-4871-9745-1bd7f72fb756
# ╟─080a827e-c525-4fb3-a81e-b1758949e18e
# ╟─08a6b27b-8aa2-4225-8f9b-576d8333c3d2
# ╟─3c84a0d4-8eeb-4feb-8276-4d62ed7492f5
# ╠═1b1df283-8089-41fc-b08f-e0e0d72253d8
# ╟─3a2663dc-9474-44b1-b9f8-13cae96c42bf
# ╠═205b547e-731d-4049-9120-0400a84b2ea0
# ╟─ea4b7a97-89da-478c-916d-5a497f03c120
# ╟─68d4acc1-7588-4a29-8a73-81ac21848568
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
