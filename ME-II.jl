### A Pluto.jl notebook ###
# v0.20.13

#> [frontmatter]
#> image = "https://github.com/Ricardo-Luis/me-2/blob/d4c738671f520db3ebc89b69cfef0cb4e3aec8c8/images/card/ME-II.png?raw=true"
#> title = "Máquinas Elétricas II"
#> date = "2025-09-01"
#> description = "Apresentação da unidade curricular: competências, programa, funcionamento e avaliação."
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

# ╔═╡ 5d6fbd00-461b-11ef-2a02-cf1ef479864a
using PlutoUI, PlutoTeachingTools, ShortCodes
#=
Brief description of the used Julia packages:
  - PlutoUI.jl, for interactive sliders
  - PlutoTeachingTools.jl, to enhance the notebook
  - ShortCodes.jl, embedded shortcodes for Pluto notebooks
=#

# ╔═╡ d3541bae-bcdb-4e58-89ce-3ad5204e5e56
Columns(md"""
		`ME-II.jl`""", md"""
		`Language:` $(@bind lang Select([
		"pt" => "Português",
		"en" => "English",
		]))""", md"""
		`Last update: 01·09·2025`""")

# ╔═╡ 399c7a6d-88da-4966-a524-9a00491809a1
if lang == "pt"
	md"# Aula de apresentação"
elseif lang == "en"
	md"# Aula de apresentação"
end

# ╔═╡ 117c889a-2c0a-4648-befb-4067cb0869a1
if lang == "pt"
	md"""
$\colorbox{Bittersweet}{\textcolor{white}{\Large\texttt{Máquinas Elétricas II (ME II)}}}$
	"""
elseif lang == "en"
	md"""
$\colorbox{Bittersweet}{\textcolor{white}{\Large\texttt{Electric Machinery II (EM II)}}}$
	"""
end

# ╔═╡ 20e8ef2a-b923-4e9d-86c8-53aafcd2d8e3
if lang == "pt"
	md"""
	### Sumário:
	- Competências
	- Programa
	- Funcionamento
	- Avaliação"""
elseif lang == "en"
		md"""
	### Sumário:
	- Competências
	- Programa
	- Funcionamento
	- Avaliação"""
end

# ╔═╡ 797e2cea-ff51-43b2-8d5b-29c6740ec9c5
if lang == "pt"
	md" # Competências a Desenvolver"
elseif lang == "en"
	md" # Competências a Desenvolver"
end

# ╔═╡ 4a679083-ab50-414c-b0e7-1c1ca50f53a0
if lang == "pt"
	md"""
	◾ **Reconhecer máquinas elétricas (ME), síncronas e de corrente contínua (CC), identificando as suas características construtivas e funcionais distintivas;**

	◾ **Resolver problemas práticos usando curvas características das ME, considerando diferentes condições de operação;**

	◾ **Distinguir processos de regulação na operação de ME, diferenciando a aplicação de princípios fundamentais e consequências práticas;**

	◾ **Selecionar procedimentos de operação de ME associadas em sistemas de acionamento e de energia, coordenando e regulando grandezas elétricas e mecânicas de forma fundamentada;**

	◾ **Explicar o funcionamento de ME não convencionais, explorando aplicações, vantagens e limitações em contextos específicos;**

	◾ **Distinguir os regimes transitórios das ME, examinando o comportamento e resultados experimentais em ensaios específicos;**

	◾ **Aplicar e analisar técnicas de instalação, operação, supervisão e manutenção de ME, executando procedimentos em ME isoladas e integradas em sistemas elétricos e industriais.**
	"""
elseif lang == "en"
		md"""
	◾ **Recognize electrical machines (EM), synchronous and direct current (DC), identifying their distinctive constructive and functional characteristics;**

	◾ **Solve practical problems using characteristic curves of EM, considering different operating conditions;**

	◾ **Distinguish regulation processes in the operation of EM, differentiating the application of fundamental principles and practical consequences;**

	◾ **Select operating procedures of EM associated in drive and energy systems, coordinating and regulating electrical and mechanical quantities in a well-founded manner;**

	◾ **Explain the operation of non-conventional EM, exploring applications, advantages and limitations in specific contexts;**

	◾ **Distinguish the transient phenomena in EM, examining the behaviour and experimental results in specific tests;**

	◾ **Apply and analyse techniques for installation, operation, supervision and maintenance of EM, executing procedures in stand-alone EM as well integrated in electrical and industrial systems.**	
	"""
end

# ╔═╡ a4d4044e-044b-40bb-87c0-f9c29d7dd07e


# ╔═╡ 6dd8ad18-9069-4500-bc84-51e502d57c37
md"""
![](https://upload.wikimedia.org/wikipedia/commons/6/6a/Bloom%27s_revised_taxonomy.svg)
"""

# ╔═╡ 596dca72-e55b-4559-862b-0807defad8a2
if lang == "pt"
	md"**Fig. 1 - Domínios das competências**, [^Tidema]."
elseif lang == "en"
	md"**Fig. 1 - Domínios das competências**, [^Tidema]."
end

# ╔═╡ 689fbf6c-8504-4648-a1da-cf5049fa5310
md"""
# Enquadramento Pedagógico 
"""

# ╔═╡ dce5565f-b004-489d-827b-b0af02c3cc6b
md"""
Aproximar os estudantes do mundo técnico das máquinas elétricas através da prática e resolução de problemas reais.
"""

# ╔═╡ 7cda7c65-c1e5-4038-8414-406b30da4675
md"""
## Metodologias:
"""

# ╔═╡ 250883b0-68da-46e8-8159-d478587e7c31
Foldable("Aprendizagem Baseada em Problemas", md"Resolução de exercícios individuais e em grupo, integrando conceitos fundamentais com aplicações práticas. A metodologia promove discussão, análise crítica e pensamento analítico, envolvendo os estudantes na aplicação progressiva da teoria a situações reais.")

# ╔═╡ f0b7a6b5-a87f-4c54-aff8-f23f5c6f726f
Foldable("Experimentação Colaborativa e Prática Reflexiva", md"As aulas Práticas direcionam os alunos para o trabalho em equipa na realização de ensaios experimentais, de modo a:
- desenvolver as competências técnicas nos procedimentos de ensaio e de segurança;
- promover a reflexão estruturada sobre as observações e os resultados obtidos; 
- através do processo iterativo de experimentação e reflexão coletiva: 
  - aprofundar a compreensão teórica dos conceitos em estudo;
  - desenvolver aptidões práticas; 
  - estimular o pensamento crítico.")

# ╔═╡ 364d1e59-c671-41ba-9be9-83aa1e167208
begin
	Julia_logo="https://github.com/JuliaLang/julia/raw/master/doc/src/assets/logo.svg"
	Pluto_logo="https://raw.githubusercontent.com/fonsp/Pluto.jl/dd0ead4caa2d29a3a2cfa1196d31e3114782d363/frontend/img/logo_white_contour.svg"

	Foldable("Integração de Tecnologias de Educação Aberta", md"""

|     |    |
|-----|:--:|
| [Linguagem de computação científica](https://julialang.org/): | $(Resource(Julia_logo, :height => 35)) |
|     |    |
| [*Notebooks* reativos](https://plutojl.org/): | $(Resource(Pluto_logo, :height => 35)) |
|     |    |

\

#### Educação aberta:

![](https://www.ub.uzh.ch/dam/jcr:0417c862-6463-465e-8f3c-b4fc585cb6e0/FAIR-data-principles.png)

**Fig. 2 - Aplicação dos princípios FAIR, [^Bezjak_2018]**

""")
end

# ╔═╡ 1b078568-4378-488d-9315-94522ab8a7f3


# ╔═╡ d6816245-7d61-4136-91f0-e8c480665278
if lang == "pt"
	md"# Programa"
elseif lang == "en"
	md"# Syllabus"
end

# ╔═╡ 689dad68-fd9d-4e6b-8adc-029ca1f08ccc
if lang == "pt"
	Foldable("Máquina de Corrente Contínua (CC)", md"
- Constituição, princípio funcionamento, tipos excitação, esquemas equivalentes
- Potência, perdas e rendimento
- Características externas de dínamos; Regulação de tensão
- Paralelo de dínamos e repartição de carga
- Características externas de motores CC
- Regulação de velocidade; Sistemas Ward-Leonard
- Arranque, travagem e inversão de marcha de motores CC ")
elseif lang == "en"
	Foldable("Direct Current (DC) Machine", md"
- Construction, operating principle, excitation types, equivalent circuits
- Power, losses and efficiency
- External characteristics of dynamos; Voltage regulation
- Association of dynamos and load sharing
- External characteristics of DC motors
- Speed regulation; Ward-Leonard systems
- Starting, braking and speed reversing of DC motors ")
end

# ╔═╡ b8c5ca70-be9d-464e-8489-fd41b8445952
if lang == "pt"
	Foldable("Máquina Síncrona (MS) trifásica", md"
- Constituição, princípio funcionamento, esquemas equivalentes
- Determinação de parâmetros (polos lisos, polos salientes)
- Potência, perdas e rendimento
- Características externas de alternador isolado
- Sincronização do alternador com a rede elétrica; Operação nos 4 quadrantes
- Curvas V; Compensador síncrono
- Associação de alternadores em paralelo: regulação de $f$ e $U$ vs. repartição de $P$ e $Q$ ")
elseif lang == "en"
		Foldable("Three-phase Synchronous Machine (SM)", md"
- Construction, operating principle, equivalent circuits
- Parameters determination (cylindrical rotor, salient poles)
- Power, losses and efficiency
- External characteristics of a stand-alone alternator
- Synchronization of alternator with electrical grid; Operation in 4 quadrants
- V-curves; Synchronous condenser	 
- Association of alternators in parallel: regulation of $f$ and $U$ vs. load sharing of $P$ and $Q$ ")
end

# ╔═╡ 90cc6fe9-0a65-4a61-93a2-296c416db981
if lang == "pt"
	Foldable("Transitórios de Máquinas Elétricas (ME)", md"
- Equação mecânica e ensaio de desaceleração\
- Estabilidade da MS\
- Curto-circuito simétrico num alternador em vazio")
elseif lang == "en"
	Foldable("Dynamics of Electrical Machines", md"
- Mechanical equation and deceleration test
- SM stability
- Symmetrical short-circuit in an alternator at no-load ")
end

# ╔═╡ 6538fe16-97a6-4886-8253-2f40593d4d81
md"""
# Main bibliography
"""

# ╔═╡ fba9f05c-7b5f-4f7c-bcd6-608ff25ff634
begin
	Sahdev = "https://m.media-amazon.com/images/I/41LC-UhrXaL._AC_UF1000,1000_QL80_.jpg"
	Guru = "https://m.media-amazon.com/images/I/71IJTb27FBL._AC_UF1000,1000_QL80_.jpg"
	Sen ="https://pictures.abebooks.com/isbn/9781118078877-us.jpg"
	Matsch = "https://m.media-amazon.com/images/I/51OAtPIq+ML._AC_UF1000,1000_QL80_.jpg"
	
	md"""
| |  |
|:--:|:--|
| $(Resource(Sahdev, :width => 140)) | S. K. Sahdev, Electrical Machines, Cambridge University Press, 2018|
| $(Resource(Guru, :width => 140)) | B.S. Guru, H.R. Hiziroglu, Electric Machinery and Transformers, Oxford Univ. Press, 2001 |	
| $(Resource(Sen, :width => 140))  | P.C. Sen, Principles of electric machines and power electronics, John Wiley & Sons, 1989 |
| $(Resource(Matsch, :width => 140))  | L.W. Matsch, J.D. Morgan, Electromagnetic and Electromechanical Machines, John Wiley & Sons, 1987 |

"""
end

# ╔═╡ 57166d2c-e6c5-4b74-8103-7746e3ace7f2
md"""
# Avaliação
"""

# ╔═╡ 656887e0-2f78-498a-90ff-eccdab3bc3f5
md"""
$\boldsymbol{\mathit{NF}}=0.45 \times MT+0.50 \times ML+0.05 \times ME$

 $\boldsymbol{\mathit{NF}}$: **Nota Final**\
 $MT$: Média dos testes (ou nota do exame)\
 $ML$: Média ponderada dos Trabalhos Laboratoriais $(TL)$\
 $ME$: Nota da apresentação da Máquina Elétrica Especial $\rm{(MEE)}$

$ML=\dfrac{\sum\limits_{i=1}^{5} TL_i \times P_i}{\sum\limits_{i=1}^{5} P_i}$

 $P_i$: peso baseado no número de aulas práticas necessárias para cada trabalho

**Componentes facultativas:** $\rm{MEE}$ e $TL_5$.
"""

# ╔═╡ f6c8f4cb-66a3-4879-8a17-85c37bab2701
md"""
# Referências

[^Tidema]: Tidema, [A visual representation of Bloom's revised taxonomy, with indications of possible classroom activities associated with each level.](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Bloom%27s_revised_taxonomy.svg/512px-Bloom%27s_revised_taxonomy.svg.png?20240919191759), [CC BY 4.0](https://creativecommons.org/licenses/by/4.0), via *Wikimedia Commons*.

[^Bezjak_2018]: Sonja Bezjak, April Clyburne-Sherin, Philipp Conzett, Pedro Fernandes, Edit Görögh, Kerstin Helbig, Bianca Kramer, Ignasi Labastida, Kyle Niemeyer, Fotis Psomopoulos, Tony Ross-Hellauer, René Schneider, Jon Tennant, Ellen Verbakel, Helene Brinken, & Lambert Heller. (2018). [The Open Science Training Handbook](https://open-science-training-handbook.gitbook.io/book). [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1212496.svg)](https://doi.org/10.5281/zenodo.1212496)
"""

# ╔═╡ c251fd12-11b6-4649-898d-70dba9f9e976
if lang == "pt"
	md"# Anexo: árvore das ME"
elseif lang == "en"
	md"# Anexo: árvore das ME"
end

# ╔═╡ 3b3aa8fe-8b09-43e5-8ca6-05860f3044ad
begin
	Tree_en = BlockDiag("""blockdiag {
	"AC machines" -> Induction -> Polyphase, "Single-phase"
	Polyphase -> "Wound rotor", "Squirrel cage" 

	"Single-phase" -> Capacitor, "Shaded pole", "Split phase", "Reluctance start"
	Capacitor -> "Capacitor start", "Permanent capacitor", "Two capacitor           start/run"

	"Permanent capacitor" -> "Multiple speed", "Single speed"

	"AC machines" -> Synchronous -> "Single/Polyphase" -> "Wound field", "Permanent magnet", Reluctance, Hysteresis, "Multiple speed pole  switching"
	"Wound field" -> "Cylindrical Rotor", "Salient Pole Rotor" 

	"AC machines" [color = "lightblue"]


	"DC machines" -> "Separately excited", "Self excited", " Permanent magnet "
	"Self excited" -> Shunt, Series, Compound
	Series -> Universal, "Split field"
	Compound -> "Long shunt", "Short shunt"
	"Long shunt" -> Cumulative, Differential 
	"Short shunt" -> " Cumulative", " Differential" 

	" Permanent magnet " -> "Conventional construction", "Moving coil", "DC torquer"
	"DC machines" [color = "lightyellow"]

  "Electronically              c o n t r o l l e d" -> Steppers , "Synchronous    phase-locked loop", "Variable frequency", "Brushless DC", "Switched reluctance", "Synchronous reluctance"
	Steppers -> "Perm. magnet", "Reluctance ", Hybrid
	"Variable frequency" -> "Synchronous ", "Induction "
	"Synchronous " -> "Wound rotor ", "Perm. magnet "
	"Induction " -> "Stator control", "Rotor control"
	"Brushless DC" -> "Inverter diven", "Electronic  commutation"
	"Electronic  commutation" -> "Trapezoidal", "Sinusoidal"
	"Synchronous reluctance" -> "PM assisteed"
    "Electronically              c o n t r o l l e d"  [color = "lightgreen"]
	
}""")
	md"Destape (👁) para visualizar..."
end

# ╔═╡ b1289346-6bbe-46a0-9721-c51acdf6e362
if lang == "pt"
	Foldable("Princípios de funcionamento de ME não convencionais", md"""
			 $(Tree_en)""")
elseif lang == "en"
	Foldable("Operating principles of special electrical machines", md"""
			 $(Tree_en)""")
end

# ╔═╡ a9501886-df7e-4c46-88b7-06e8344b01fd
# Define alinhamento justificado para distribuir uniformemente o texto entre as margens + fonte principal:
html"""<style>
pluto-output p {
    text-align: justify;
}
pluto-output {
    font-family: system-ui;
	font-size:  100%
}
</style>
"""

# ╔═╡ 5b3c89b5-a757-4709-9bdb-f3e0feff5da1
md"""
# Notebook
"""

# ╔═╡ bf113704-6d60-4677-901c-79d0125bc3c0
if lang == "pt"
	md"""
	Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [ShortCodes](https://raw.githack.com/hellemo/ShortCodes.jl/main/examples/static-demo.html).
	"""
elseif lang == "en"
	md"""
	`Julia` packages documentation: [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [ShortCodes](https://raw.githack.com/hellemo/ShortCodes.jl/main/examples/static-demo.html).
	"""
end

# ╔═╡ 1f89f453-7484-4f78-8518-1ef4b8b52d82
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

# ╔═╡ d1ffe50a-1491-4b03-8c58-f90d41fd3229
if lang == "pt"
	TableOfContents(title="Índice", depth=1)
elseif lang == "en"
	TableOfContents(depth=1)
end

# ╔═╡ 8c3e700e-4db1-4e2e-a0d1-b7c2cf724b74
md"""
|  |  |
|:--:|:--|
|  | This notebook, [ME-II.jl](https://ricardo-luis.github.io/me-2/ME-II.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
ShortCodes = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"

[compat]
PlutoTeachingTools = "~0.4.4"
PlutoUI = "~0.7.69"
ShortCodes = "~0.3.6"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "2bc791f8c41236b76a2872d1a1a7232983304a74"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

    [deps.ColorTypes.weakdeps]
    StyledStrings = "f489334b-da3d-4c2e-b8f0-e476e12c162b"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

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

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "PrecompileTools", "StructTypes", "UUIDs"]
git-tree-sha1 = "411eccfe8aba0814ffa0fdf4860913ed09c34975"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.14.3"

    [deps.JSON3.extensions]
    JSON3ArrowExt = ["ArrowTypes"]

    [deps.JSON3.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

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

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

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

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

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
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.ShortCodes]]
deps = ["Base64", "CodecZlib", "Downloads", "JSON3", "Memoize", "URIs", "UUIDs"]
git-tree-sha1 = "5844ee60d9fd30a891d48bab77ac9e16791a0a57"
uuid = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
version = "0.3.6"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "159331b30e94d7b11379037feeb9b690950cace8"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

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

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─d3541bae-bcdb-4e58-89ce-3ad5204e5e56
# ╟─399c7a6d-88da-4966-a524-9a00491809a1
# ╟─117c889a-2c0a-4648-befb-4067cb0869a1
# ╟─20e8ef2a-b923-4e9d-86c8-53aafcd2d8e3
# ╟─797e2cea-ff51-43b2-8d5b-29c6740ec9c5
# ╟─4a679083-ab50-414c-b0e7-1c1ca50f53a0
# ╟─a4d4044e-044b-40bb-87c0-f9c29d7dd07e
# ╟─6dd8ad18-9069-4500-bc84-51e502d57c37
# ╠═596dca72-e55b-4559-862b-0807defad8a2
# ╟─689fbf6c-8504-4648-a1da-cf5049fa5310
# ╟─dce5565f-b004-489d-827b-b0af02c3cc6b
# ╟─7cda7c65-c1e5-4038-8414-406b30da4675
# ╟─250883b0-68da-46e8-8159-d478587e7c31
# ╟─f0b7a6b5-a87f-4c54-aff8-f23f5c6f726f
# ╟─364d1e59-c671-41ba-9be9-83aa1e167208
# ╟─1b078568-4378-488d-9315-94522ab8a7f3
# ╟─d6816245-7d61-4136-91f0-e8c480665278
# ╟─689dad68-fd9d-4e6b-8adc-029ca1f08ccc
# ╟─b8c5ca70-be9d-464e-8489-fd41b8445952
# ╟─90cc6fe9-0a65-4a61-93a2-296c416db981
# ╟─b1289346-6bbe-46a0-9721-c51acdf6e362
# ╟─6538fe16-97a6-4886-8253-2f40593d4d81
# ╟─fba9f05c-7b5f-4f7c-bcd6-608ff25ff634
# ╟─57166d2c-e6c5-4b74-8103-7746e3ace7f2
# ╟─656887e0-2f78-498a-90ff-eccdab3bc3f5
# ╟─f6c8f4cb-66a3-4879-8a17-85c37bab2701
# ╟─c251fd12-11b6-4649-898d-70dba9f9e976
# ╟─3b3aa8fe-8b09-43e5-8ca6-05860f3044ad
# ╟─a9501886-df7e-4c46-88b7-06e8344b01fd
# ╟─5b3c89b5-a757-4709-9bdb-f3e0feff5da1
# ╟─bf113704-6d60-4677-901c-79d0125bc3c0
# ╠═5d6fbd00-461b-11ef-2a02-cf1ef479864a
# ╟─1f89f453-7484-4f78-8518-1ef4b8b52d82
# ╠═d1ffe50a-1491-4b03-8c58-f90d41fd3229
# ╟─8c3e700e-4db1-4e2e-a0d1-b7c2cf724b74
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
