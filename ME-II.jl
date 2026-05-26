### A Pluto.jl notebook ###
# v0.20.21

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
		`Last update: 26·05·2026`""")

# ╔═╡ 399c7a6d-88da-4966-a524-9a00491809a1
if lang == "pt"
	md"# Apresentação da Unidade Curricular"
elseif lang == "en"
	md"# Course Presentation"
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
	### Summary:
	- Competencies
	- Syllabus
	- Course Organization
	- Assessment"""
end

# ╔═╡ 797e2cea-ff51-43b2-8d5b-29c6740ec9c5
if lang == "pt"
	md" # Competências a Desenvolver"
elseif lang == "en"
	md" # Competencies to Develop"
end

# ╔═╡ 4a679083-ab50-414c-b0e7-1c1ca50f53a0
if lang == "pt"
	md"""
	- **Reconhecer máquinas elétricas (ME), síncronas e de corrente contínua (CC), identificando as suas características construtivas e funcionais distintivas;**

	
	- **Resolver problemas práticos usando curvas características das ME, considerando diferentes condições de operação;**

	
	- **Distinguir processos de regulação na operação de ME, diferenciando a aplicação de princípios fundamentais e consequências práticas;**

	
	- **Selecionar procedimentos de operação de ME associadas em sistemas de acionamento e de energia, coordenando e regulando grandezas elétricas e mecânicas de forma fundamentada;**

	
	- **Explicar o funcionamento de ME não convencionais, explorando aplicações, vantagens e limitações em contextos específicos;**

	
	- **Distinguir os regimes transitórios das ME, examinando o comportamento e resultados experimentais em ensaios específicos;**

	
	- **Aplicar e analisar técnicas de instalação, operação, supervisão e manutenção de ME, executando procedimentos em ME isoladas e integradas em sistemas elétricos e industriais.**
	"""
elseif lang == "en"
		md"""
	- **Recognize electrical machines (EM), synchronous and direct current (DC), identifying their distinctive constructive and functional characteristics;**

	
	- **Solve practical problems using characteristic curves of EM, considering different operating conditions;**

	
	- **Distinguish regulation processes in the operation of EM, differentiating the application of fundamental principles and practical consequences;**

	
	- **Select operating procedures of EM associated in drive and energy systems, coordinating and regulating electrical and mechanical quantities in a well-founded manner;**

	
	- **Explain the operation of non-conventional EM, exploring applications, advantages and limitations in specific contexts;**

	
	- **Distinguish the transient phenomena in EM, examining the behaviour and experimental results in specific tests;**

	
	- **Apply and analyse techniques for installation, operation, supervision and maintenance of EM, executing procedures in stand-alone EM as well integrated in electrical and industrial systems.**	
	"""
end

# ╔═╡ 6dd8ad18-9069-4500-bc84-51e502d57c37
md"""
![](https://upload.wikimedia.org/wikipedia/commons/6/6a/Bloom%27s_revised_taxonomy.svg)
"""

# ╔═╡ 596dca72-e55b-4559-862b-0807defad8a2
if lang == "pt"
	md"**Fig. 1 - Domínios das competências**, [^Tidema]."
elseif lang == "en"
	md"**Fig. 1 - Competency domains**, [^Tidema]."
end

# ╔═╡ 689fbf6c-8504-4648-a1da-cf5049fa5310
if lang == "pt"
	md"# Enquadramento Pedagógico"
elseif lang == "en"
	md"# Pedagogical Framework"
end

# ╔═╡ dce5565f-b004-489d-827b-b0af02c3cc6b
if lang == "pt"
	md"""
	Aproximar os estudantes do mundo técnico das máquinas elétricas através da prática e resolução de problemas reais.
	"""
elseif lang == "en"
	md"""
	Connecting students with the technical world of electrical machines through practice and real problem solving.
	"""
end

# ╔═╡ 7cda7c65-c1e5-4038-8414-406b30da4675
if lang == "pt"
	md"## Metodologias"
elseif lang == "en"
	md"## Methodologies"
end

# ╔═╡ 250883b0-68da-46e8-8159-d478587e7c31
if lang == "pt"
	Foldable("Aprendizagem Baseada em Problemas", md"Resolução de exercícios individuais e em grupo, integrando conceitos fundamentais com aplicações práticas. A metodologia promove discussão, análise crítica e pensamento analítico, envolvendo os estudantes na aplicação progressiva da teoria a situações reais.")
elseif lang == "en"
	Foldable("Problem-Based Learning", md"Individual and group problem solving, integrating fundamental concepts with practical applications. The methodology promotes discussion, critical analysis and analytical thinking, engaging students in the progressive application of theory to real situations.")
end

# ╔═╡ f0b7a6b5-a87f-4c54-aff8-f23f5c6f726f
if lang == "pt"
	Foldable("Experimentação Colaborativa e Prática Reflexiva", 
			 md"""
			 As aulas Práticas direcionam os alunos para o trabalho em equipa na realização de ensaios experimentais, de modo a:
			 - desenvolver as competências técnicas nos procedimentos de ensaio e de segurança;
			 - promover a reflexão estruturada sobre as observações e os resultados obtidos;
			 - através do processo iterativo de experimentação e reflexão coletiva:
			   - aprofundar a compreensão teórica dos conceitos em estudo;
			   - desenvolver aptidões práticas;
			   - estimular o pensamento crítico.""")
elseif lang == "en"
	Foldable("Collaborative Experimentation and Reflective Practice", 
			 md"""
			 Practical classes direct students to teamwork in conducting experimental tests, in order to:
			 - develop technical competencies in testing and safety procedures;
			 - promote structured reflection on observations and results obtained;
			 - through the iterative process of experimentation and collective reflection:
			   - deepen theoretical understanding of concepts under study;
			   - develop practical skills;
			   - stimulate critical thinking.""")
end

# ╔═╡ 364d1e59-c671-41ba-9be9-83aa1e167208
begin
	Julia_logo="https://github.com/JuliaLang/julia/raw/master/doc/src/assets/logo.svg"
	Pluto_logo="https://raw.githubusercontent.com/fonsp/Pluto.jl/dd0ead4caa2d29a3a2cfa1196d31e3114782d363/frontend/img/logo_white_contour.svg"

	if lang == "pt"
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
	elseif lang == "en"
		Foldable("Integration of Open Education Technologies", md"""
	|     |    |
	|-----|:--:|
	| [Scientific computing language](https://julialang.org/): | $(Resource(Julia_logo, :height => 35)) |
	|     |    |
	| [Reactive notebooks](https://plutojl.org/): | $(Resource(Pluto_logo, :height => 35)) |
	|     |    |
				 
	\
				 
	#### Open education:
				 
	![](https://www.ub.uzh.ch/dam/jcr:0417c862-6463-465e-8f3c-b4fc585cb6e0/FAIR-data-principles.png)
	**Fig. 2 - Application of FAIR principles, [^Bezjak_2018]**
	""")
	end
end

# ╔═╡ eb8ba078-3c71-4f50-8964-d4cadb20af2e


# ╔═╡ aaaf7c2e-c16d-43d9-9cbc-f651c67e93c4
if lang == "pt"
	md"## ✨ **Wattutor**: o tutor IA de ME II (beta)"
elseif lang == "en"
	md"## ✨ **Wattutor**: the AI tutor for EM II (beta)"
end

# ╔═╡ 42ee7dfc-33da-40eb-b595-2ae450708bc8
begin
	if lang == "pt"
		
md"""
O **Wattutor** é um agente de Inteligência Artificial (IA) baseado em modelos de linguagem de grande dimensão (LLM), disponível na plataforma IAedu como recurso pedagógico complementar em ME II. 

Esta secção apresenta boas práticas de utilização e enquadra o assistente no ensino de engenharia na era da IA generativa, promovendo o desenvolvimento da autonomia técnica e da responsabilidade profissional.
	

$(aside(Foldable("Sobre o nome Wattutor", md"

![](https://s3-eu-west-1.amazonaws.com/ngs-mw-prod/2/87/41782/41782.jpg)

_[James Watt and the Steam Engine: the Dawn of the Nineteenth Century](https://www.nationalgalleries.org/art-and-artists/5690) (1855), da autoria do pintor James Eckford Lauder. Acervo da [National Galleries of Scotland](https://www.nationalgalleries.org/). Licença: [Public Domain Mark 1.0](https://creativecommons.org/publicdomain/mark/1.0/deed.pt)._

O nome **Wattutor** funde a unidade de potência (o watt) com a função de tutoria (tutor). Trata-se de uma homenagem a **James Watt** (1736–1819), matemático e engenheiro escocês cujo trabalho no desenvolvimento da máquina a vapor impulsionou a Revolução Industrial e transformou a engenharia e a conversão de energia.

No âmbito da eletrotecnia e das máquinas elétricas, o watt (W) constitui a unidade de referência no Sistema Internacional de Unidades, utilizada no cálculo das potências, na avaliação de perdas e na consequente definição do rendimento. 

O prefixo **Wat** evoca o rigor na conversão de energia, enquanto o sufixo **tutor** define o propósito da ferramenta: guiar o estudo dos estudantes, promovendo a responsabilidade e o rigor na aplicação destes conceitos.
"),v_offset=-70))
"""
	elseif lang == "en"
md"""
**Wattutor** is an Artificial Intelligence (AI) agent based on Large Language Models (LLMs), available on the IAedu platform as a complementary pedagogical resource for ME II. 

This section presents best practices for its use and contextualizes the assistant within engineering education in the era of generative AI, fostering the development of technical autonomy and professional responsibility.

$(aside(Foldable("About the name Wattutor", md"
![](https://s3-eu-west-1.amazonaws.com/ngs-mw-prod/2/87/41782/41782.jpg)

_[James Watt and the Steam Engine: the Dawn of the Nineteenth Century](https://www.nationalgalleries.org/art-and-artists/5690) (1855), by the painter James Eckford Lauder. Collection of the National Galleries of Scotland. License: [Public Domain Mark 1.0](https://creativecommons.org/publicdomain/mark/1.0/deed.en)._
		
The name Wattutor blends the unit of power (the watt) with the role of tutoring (tutor). It is a tribute to James Watt (1736–1819), the Scottish mathematician and engineer whose development of the steam engine drove the Industrial Revolution and transformed engineering and energy conversion.
		
In the field of electrical engineering and electrical machines, the watt (W) constitutes the reference unit within the International System of Units (SI) used for power calculation, loss evaluation, and the subsequent definition of efficiency.
		
The prefix Wat evokes rigor in energy conversion, while the suffix tutor defines the purpose of the tool: to guide students in their studies, promoting responsibility and rigor in the application of these concepts.

"),v_offset=-70))
"""
	end
end	

# ╔═╡ 4d848824-62a6-4898-a4af-72e6b1bf3603
begin
	wattutor="https://raw.githubusercontent.com/Ricardo-Luis/me-2/main/images/wattutor.png"

	iaedu="https://iaedu.pt/themes/custom/fct_theme/logo.svg"

	iaedu_login="https://iaedu.pt/pt"

	if lang == "pt"

md"""
	
| | |
|:--|:--|
| $\qquad\qquad$![](https://iaedu.pt/themes/custom/fct_theme/logo.svg) | $$\qquad$$ $(Resource(wattutor, :height => 120)) |
| Acesso centralizado e simplificado aos modelos de IA $\quad$ | **Wattutor: tutor IA de ME II (beta)** |
| Disponibilização de modelos de IA de acesso livre | Agente de IA disponível na IAedu |
| Autenticação única e federada | **Aceda com a sua conta IPL** |
		
\
		
📢 **Como aceder ao Wattutor:**
		
1. Aceda à [plataforma IAedu](https://iaedu.pt/pt);
1. Faça _login_ com a sua conta institucional do IPL;
1. Na lista de agentes, procure por **Wattutor** (o tutor IA de ME II).
	
"""

	elseif lang == "en"
md"""
| | |
|:--|:--|
| $\qquad\qquad$![](https://iaedu.pt/themes/custom/fct_theme/logo.svg) | $$\qquad$$ $(Resource(wattutor, :height => 120)) |
| Centralized and simplified access to AI models $\quad$ | **Wattutor: EM II AI Tutor (beta)** |
| Available open-access AI models | AI agent available on IAedu |
| Single and federated authentication | **Access with your IPL account** |


\

📢 **How to access Wattutor:**
1. Go to the [IAedu platform](https://iaedu.pt/en);
1. Log in using your IPL institutional account;
1. In the agents list, look for **Wattutor** (the EM II AI tutor).

"""	
	end
end

# ╔═╡ 829944ba-ae63-423e-a7ab-cbf03c387084
begin
	if lang == "pt"

md"""
## ✨ **IA na Engenharia**: Saber Usar, Saber Pensar
"""

	elseif lang == "en"

md"""
## ✨ **AI in Engineering**: How to Use, How to Think
"""
	end
end

# ╔═╡ 43ae90f4-7178-4fe0-a998-6285f268aba0
begin
	if lang == "pt"

Foldable("Como o Wattutor pode ajudar?", md"""


**Wattutor**: o tutor de IA 24/7 de ME II. Aplicado a máquinas CC e síncronas 3~, desenvolvido para orientar o raciocínio analítico sem fornecer soluções diretas.

| ✔ O Wattutor ajuda a... | ✗ O Wattutor não faz... |
|:---|:---|
| Sugerir abordagens metodológicas para exercícios | Resolver problemas ou avaliações no lugar do utilizador |
| Clarificar passos intermédios em cálculos e derivações | Funcionar como um oráculo isento de erros técnicos |
| Explicar conceitos de máquinas CC, síncronas 3~ e dinâmica | Substituir a compreensão física dos fenómenos elétricos |
| Apoiar na interpretação de ensaios laboratoriais | Inventar referências, fórmulas ou critérios de avaliação |
| Rever e explicar código `Julia` ou *notebooks* Pluto | Dispensar a observação da honestidade académica |
| Esclarecer dúvidas fora do horário de atendimento | Dispensar a consulta aos docentes para validações finais |
		 
\
		 
#### Como tirar partido do **Wattutor**

- **Tentativa prévia:** recomenda-se tentar resolver o problema antes de solicitar apoio.
- **Contextualização:** apresenta-se o trabalho já desenvolvido e não apenas o enunciado.
- **Foco no método:** solicita-se orientação metodológica e nunca a solução final direta.

> O **Wattutor** orienta a atenção sobre os conteúdos, mas não substitui o estudo crítico e autónomo sobre o funcionamento e aplicação das máquinas elétricas.

📍 **Acesso:** [IAedu](https://iaedu.pt/pt) → **Wattutor** · Disponível 24/7 · Resposta em PT / EN · Sem limite de perguntas
""")

	elseif lang == "en"
		
Foldable("How can Wattutor help?", md"""

**Wattutor**: the 24/7 AI tutor for EM II. Applied to DC and 3-ph synchronous machines, designed to guide analytical reasoning without providing direct solutions.


| ✔ Wattutor helps to... | ✗ Wattutor does not... |
|:---|:---|
| Suggest methodological approaches for exercises | Solve problems or assessments for the user |
| Clarify intermediate steps in calculations and derivations | Act as an oracle free from technical errors |
| Explain concepts of DC machines, 3~ synchronous machines, and dynamics | Replace the physical understanding of electrical phenomena |
| Support the interpretation of laboratory tests | Invent references, formulas, or grading criteria |
| Review and explain `Julia` code or Pluto *notebooks* | Waive compliance with academic integrity |
| Clarify questions outside office hours | Replace consulting professors for final validations |
		 
\
		 
#### How to make the most of **Wattutor**

- **Prior attempt:** it is recommended to try solving the problem before asking for support.
- **Contextualization:** present the work already developed and not just the problem statement.
- **Focus on method:** request methodological guidance and never the direct final solution.

> **Wattutor** guides attention to the course content but does not replace critical and independent study on the operation and application of electrical machines.

📍 **Access:** [IAedu](https://iaedu.pt/en) → **Wattutor** · Available 24/7 · Response in PT / EN · No question limit
""")
	end
end

# ╔═╡ aed1be60-b09d-4683-ad65-5ecb3e21cb4c
begin
	if lang == "pt"

Foldable("Engenharia de prompts em ME II", md"""

As respostas do **Wattutor** refletem o rigor das perguntas submetidas. A engenharia de _prompts_ é o processo de estruturar, otimizar e refinar o texto de entrada fornecido a uma IA para garantir que a resposta gerada seja o mais precisa e útil possível.

#### Estrutura base de um bom _prompt_

```
[Contexto do problema] + [O que já sei / tentei] + [Pedido específico]
```

---

#### Exemplos práticos em ME-II

**❌ Prompt fraco:**
> "Explica máquinas síncronas."

**✅ Prompt eficaz:**
> "Estou a estudar máquinas síncronas trifásicas em regime permanente. Percebi que a FEM interna *E₀* aumenta com a corrente de excitação, mas não entendo por que a máquina pode absorver ou fornecer potência reativa dependendo do nível de excitação. Podes explicar o raciocínio físico, usando o diagrama fasorial, passo a passo?"

---

**❌ Prompt fraco:**
> "O meu código não funciona."

**✅ Prompt eficaz:**
> "Estou a implementar em Julia o cálculo da velocidade de regime de um motor DC de excitação separada. Tenho este código [colar código]. O erro que obtenho é [descrever erro]. O problema parece estar na interpolação da curva de magnetização. Podes identificar o erro e explicar porquê?"

---

**❌ Prompt fraco:**
> "Verifica o meu cálculo."

**✅ Prompt eficaz:**
> "Numa máquina síncrona com Sn = 500 kVA, Vn = 6,6 kV (ligação triângulo), calculei uma corrente nominal de fase de 43,7 A. O meu raciocínio foi: *In = Sn / (√3 · Vn)*. Esta corrente não deveria ser a corrente do circuito equivalente da máquina por fase?"

---

💡 **Regra prática:** Quanto mais contexto fornecer, mais útil será a resposta. Inclua sempre o tópico, o que já sabe e, concretamente, o que não percebe.
"""	
)

	elseif lang == "en"

Foldable("Prompt Engineering in ME II", md"""

The answers provided by **Wattutor** reflect the rigor of the submitted questions. Prompt engineering is the process of structuring, optimizing, and refining the input text provided to an AI to ensure that the generated response is as precise and useful as possible.

#### Base structure of a good prompt

```
[Problem Context] + [What I already know / tried] + [Specific Request]
```

---

#### Practical examples in ME-II

**❌ Weak prompt:**
> "Explain synchronous machines."

**✅ Effective prompt:**
> "I am studying three-phase synchronous machines in steady-state. I understand that the internal EMF *E₀* increases with the excitation current, but I don't understand why the machine can absorb or deliver reactive power depending on the excitation level. Can you explain the physical reasoning step by step, using the phasor diagram?"

---

**❌ Weak prompt:**
> "My code doesn't work."

**✅ Effective prompt:**
> "I am implementing the calculation of the steady-state speed of a separately excited DC motor in Julia. I have this code [paste code]. The error I get is [describe error]. The problem seems to be in the interpolation of the magnetization curve. Can you identify the bug and explain why it happens?"

---

**❌ Weak prompt:**
> "Check my calculation."

**✅ Effective prompt:**
> "In a synchronous machine with Sn = 500 kVA, Vn = 6.6 kV (delta connection), I calculated a rated phase current of 43.7 A. My reasoning was: *In = Sn / (√3 · Vn)*. Shouldn't this current be the per-phase equivalent circuit current of the machine?"

---

💡 **Rule of thumb:** The more context you provide, the more helpful the answer will be. Always include the topic, what you already know, and, concretely, what you do not understand.
"""	
)
	end
end

# ╔═╡ dc79aea5-428a-4af3-8f49-293896aad766
begin
	if lang == "pt"

Foldable("Fiabilidade da IA e compromisso académico", md"""

#### Alucinações

Os modelos de linguagem (LLMs) podem produzir respostas plausíveis mas erradas, contendo fórmulas incorretas, valores inventados ou raciocínios fisicamente incoerentes. Este risco manifesta-se mesmo em tópicos consolidados como as máquinas elétricas.

Exemplos de erros típicos em ME II:
- Expressões para a resistência de armadura com inversão de sinais;
- Confusão conceptual entre a convenção de motor e a convenção de gerador;
- Relações de fase ou de linha incorretas em sistemas trifásicos;
- Definição incorreta de condições de estabilidade em regime transitório.

**Regra prática:** Nenhuma resposta gerada por IA deve ser utilizada sem validação prévia face aos conteúdos programáticos, ao material didático da disciplina ou a outras fontes bibliográficas fiáveis.

#### Dependência acrítica

A dependência de soluções automáticas enfraquece o raciocínio crítico. Para garantir uma aprendizagem efetiva, a tecnologia deve apoiar o estudo e nunca substituir o esforço de resolução.

O objetivo central em ME II consiste na compreensão do funcionamento e na análise da operação das máquinas elétricas. A IA atua exclusivamente como um instrumento de apoio ao estudo, não constituindo um mecanismo para contornar o processo de aprendizagem.

#### Integridade académica

- A utilização de ferramentas de IA em componentes sujeitas a avaliação rege-se pelo [Código Conduta](https://files.diariodarepublica.pt/2s/2023/12/233000000/0027700287.pdf) da instituição e pelas diretrizes específicas estipuladas pelo corpo docente;
- Sempre que a IA for integrada no desenvolvimento de um trabalho, impõe-se a declaração explícita da sua utilização e a descrição da sua função;
- A responsabilidade técnica e científica pelo conteúdo submetido recai inteiramente sobre os autores do trabalho.
"""
)

	elseif lang == "en"

Foldable("AI Reliability and Academic Commitment", md"""

#### Hallucinations

Large Language Models (LLMs) can produce plausible-sounding but wrong answers, containing incorrect formulas, fabricated values, or physically inconsistent reasoning. This risk manifests itself even in established topics such as electrical machines.

Examples of typical errors in ME II:
- Expressions for armature resistance with inverted signs;
- Conceptual confusion between motor and generator conventions;
- Incorrect phase or line relationships in three-phase systems;
- Incorrect definition of transient stability conditions.

**Rule of thumb:** No AI-generated response should be used without prior validation against the syllabus, course textbooks, or other reliable bibliographic sources.

#### Uncritical Dependence

Dependence on automated solutions weakens critical reasoning. To ensure effective learning, technology must support studying and never replace the effort required for problem-solving.

The core objective of ME II is to understand the operation and analyze the performance of electrical machines. AI acts exclusively as a study aid, and does not constitute a mechanism to bypass the learning process.

#### Academic Integrity

- The use of AI tools in graded components is governed by the institution's [Code of Conduct](https://files.diariodarepublica.pt/2s/2023/12/233000000/0027700287.pdf) and the specific guidelines stipulated by the teaching staff;
- Whenever AI is integrated into the development of coursework, explicit declaration of its use and a description of its role are required;
- The technical and scientific responsibility for the submitted content rests entirely with the authors of the work.
"""
)
	end
end

# ╔═╡ ecfea3f4-6a77-4cb1-8254-0c8a6d1651cb
begin
	if lang == "pt"

Foldable("Dimensões da literacia em IA na engenharia", md"""

A literacia em IA emerge como uma competência fundamental para a engenharia, abrangendo quatro dimensões interdependentes:



| Dimensão | Descrição | Em ME II |
|:---|:---|:---|
| **Técnica** | Compreensão do funcionamento dos LLMs e das suas limitações | Reconhecimento de erros em fórmulas ou raciocínios gerados |
| **Crítica** | Validação de resultados com deteção de erros e incoerências | Verificação da plausibilidade física das respostas obtidas |
| **Ética** | Responsabilidade pelo trabalho e transparência na utilização | Rejeição da submissão de conteúdo gerado por IA como próprio |
| **Colaborativa** | Integração da IA como um recurso de interação e suporte | Iteração do _prompt_ até à obtenção de uma explicação útil |

Integrar a literacia em IA ao longo do curso é essencial para preparar futuros engenheiros capazes de responder às exigências tecnológicas atuais.

---

> *"Utilizar a IA para otimizar o tempo de trabalho nunca deve comprometer o desenvolvimento da autonomia técnica e do raciocínio analítico próprio."*
"""
)

	elseif lang == "en"

Foldable("Dimensions of AI Literacy in Engineering", md"""

AI literacy emerges as a foundational skill for engineering, encompassing four interdependent dimensions:


| Dimension | Description | In ME II |
|:---|:---|:---|
| **Technical** | Understanding how LLMs operate and their limitations | Recognizing errors in formulas or generated reasoning |
| **Critical** | Validating results through error and inconsistency detection | Verifying the physical plausibility of the obtained answers |
| **Ethical** | Responsibility for one's work and transparency in usage | Rejecting the submission of AI-generated content as one's own |
| **Collaborative** | Integrating AI as a resource for interaction and support | Iterating the prompt until a useful explanation is achieved |

Integrating AI literacy throughout the curriculum is essential to prepare future engineers capable of meeting today's technological demands.

---

> *"Using AI to optimize work time must never compromise the development of technical autonomy and one's own analytical reasoning."*
"""
)
	end
end

# ╔═╡ 562c4904-227a-4950-bbb5-dfa43c8e778b
begin
	if lang == "pt"

Foldable("O novo paradigma do saber em engenharia", md"""

#### Reconfiguração das exigências técnicas

A inteligência artificial (IA) está a redefinir o conceito de conhecimento na engenharia. Não se trata de uma tendência passageira, mas sim de uma mudança estrutural na forma como se aprende, calcula e projeta.

> *"O núcleo da competência desloca-se da execução manual para a combinação do raciocínio de engenharia com a literacia em IA."*

Anteriormente, o conhecimento em engenharia estava associado sobretudo ao domínio de procedimentos, tais como a resolução manual de circuitos, a aplicação de métodos numéricos ou o seguimento estrito de normas de projeto. Com a omnipresença da IA generativa, as exigências reconfiguram-se:


| Antes | Com IA omnipresente |
|:---|:---|
| Execução de algoritmos e cálculos $\qquad\qquad\qquad\qquad\quad$ | Modelação de problemas e validação de resultados $\quad$ Formulação de perguntas e *prompts* eficazes |
| Memorização de métodos e fórmulas | Depuração, verificação e interpretação de dados |
| Produção manual de resultados | Utilização da IA como recurso de suporte |
| Utilização de ferramentas isoladas | Gestão da IA como assistente com limites conhecidos |

\

#### Dimensões do conhecimento prático

##### 🧮 O que é **saber calcular** na era da IA?

O foco desloca-se do cálculo operacional manual para a modelação, validação e interpretação. A IA pode executar as operações matemáticas, competindo ao utilizador verificar se o resultado é fisicamente plausível e coerente com o modelo adotado.

Em ME II, este princípio implica compreender a fundamentação de um balanço de potências numa máquina de corrente contínua, entender a representação de uma curva de magnetização ou reconhecer quando uma solução de regime transitório é fisicamente impossível, independentemente dos dados produzidos pela ferramenta.

##### 🔬 O que é **saber experimentar** na era da IA?

O laboratório constitui o teste de realidade para os modelos teóricos. A competência experimental reside no planeamento de ensaios, na medição de grandezas reais, na gestão de incertezas e limitações dos instrumentos, bem como na interpretação das discrepâncias entre as previsões teóricas e os registos experimentais.

Em ME II, os ensaios laboratoriais exigem rigor procedimental, sentido crítico sobre os resultados e a capacidade de relacionar o comportamento real das máquinas elétricas com o respetivo circuito equivalente.

Com a omnipresença da IA, surge o risco específico de confundir a simulação computacional com o ensaio físico real. Os sistemas de IA reproduzem resultados previstos por modelos matemáticos, mas não substituem a experiência prática de medição, a gestão de imprevistos e a compreensão dos desvios entre a realidade física e o modelo.

##### ⌨ O que é **saber programar** na era da IA?

Esta competência passa a incluir a formulação de instruções precisas, através da descrição clara do problema, do contexto, das variáveis e das condições de fronteira. A qualidade do resultado gerado depende diretamente da precisão da instrução fornecida.

Saber programar em Julia com *notebooks* Pluto implica também a capacidade de verificar e adaptar código gerado de forma automática, reconhecer erros lógicos e compreender os algoritmos subjacentes, evitando a mera execução cega de rotinas.

##### 💡 O que é **saber projetar** na era da IA?

O desenvolvimento de projetos com IA baseia-se numa colaboração crítica entre o utilizador e a máquina. As ferramentas generativas aceleram a geração de ideias e a prototipagem, mas podem induzir a conclusões prematuras ou a soluções superficiais se forem utilizadas sem reflexão crítica.

O engenheiro atua como o orquestrador do processo e assume a responsabilidade final pelo resultado obtido, incluindo as respetivas implicações técnicas, económicas e éticas.
"""
)

	elseif lang == "en"

Foldable("The New Paradigm of Engineering Knowledge", md"""

#### Reconfiguration of Technical Demands

Artificial intelligence (AI) is redefining the concept of knowledge in engineering. This is not a passing trend, but a structural shift in how we learn, calculate, and design.

> *"The core of competence shifts from manual execution to the combination of engineering reasoning with AI literacy."*

Previously, engineering knowledge was primarily associated with mastering procedures, such as solving circuits manually, applying numerical methods, or strictly following design standards. With the ubiquity of generative AI, the demands are reconfigured:



| Before | With Ubiquitous AI |
|:---|:---|
| Executing algorithms and calculations $\qquad\qquad\qquad\qquad\quad$ | Problem modeling and validation of results $\quad$ Formulating questions and effective prompts |
| Memorizing methods and formulas | Debugging, verifying, and interpreting data |
| Manual production of results | Utilizing AI as a support resource |
| Using isolated tools | Managing AI as an assistant with known limitations |

\

#### Dimensions of Practical Knowledge

##### 🧮 What is **knowing how to calculate** in the AI era?

The focus shifts from manual operational calculation to modeling, validation, and interpretation. AI can execute mathematical operations, but it is up to the user to verify whether the result is physically plausible and consistent with the adopted model.

In EM II, this principle implies understanding the foundational basis of a power balance in a DC machine, understanding the representation of a magnetization curve, or recognizing when a transient solution is physically impossible, regardless of the data produced by the tool.

##### 🔬 What is **knowing how to experiment** in the AI era?

The laboratory serves as the reality check for theoretical models. Experimental competence lies in planning tests, measuring real quantities, managing uncertainties and instrument limitations, as well as interpreting discrepancies between theoretical predictions and experimental records.

In EM II, laboratory tests require procedural rigor, a critical mindset regarding the results, and the ability to relate the actual behavior of electrical machines to their respective equivalent circuits.

With the ubiquity of AI, there is a specific risk of confusing computer simulation with actual physical testing. AI systems reproduce results predicted by mathematical models, but they do not replace the hands-on experience of measuring, handling unexpected events, and understanding deviations between physical reality and the model.

##### ⌨ What is **knowing how to program** in the AI era?

This skill now includes the formulation of precise instructions through a clear description of the problem, context, variables, and boundary conditions. The quality of the generated output depends directly on the precision of the instruction provided.

Knowing how to program in Julia using Pluto *notebooks* also implies the ability to verify and adapt automatically generated code, recognize logical bugs, and understand the underlying algorithms, avoiding the mere blind execution of routines.

##### 💡 What is **knowing how to design** in the AI era?

Developing projects with AI is based on a critical collaboration between the user and the machine. Generative tools accelerate idea generation and prototyping, but they can induce premature conclusions or superficial solutions if used without critical reflection.

The engineer acts as the orchestrator of the process and bears the final responsibility for the obtained result, including its technical, economic, and ethical implications.
"""
)
	end
end

# ╔═╡ 69669b2a-bc2c-4311-8437-f046bb5bc9c3
begin
	if lang == "pt"

Foldable("Impacto da IA nas etapas de engenharia", md"""

A IA generativa não altera a essência da engenharia, apenas modifica o espaço onde esta se desenvolve.

| Etapa | Ações técnicas | Natureza do trabalho |
|:---|:---|:---|
| **Formular** $\qquad\qquad\qquad\qquad$ | Definir o problema correto $\qquad\qquad\qquad\qquad$ Escolher o modelo e os seus limites de validade Estabelecer os critérios de aceitação | Permanece humano |
| **Executar** $\qquad\qquad\qquad\qquad$ | Cálcular; Simular; Programar; Otimizar | Cada vez mais assistido pela IA |
| **Validar e decidir** | Verificar a plausibilidade física do resultado Interpretar as implicações técnicas $\qquad\qquad\qquad$ Assumir a responsabilidade técnica e profissional | Permanece humano |

\

##### Dependência técnica e discernimento		 

O uso de ferramentas de IA apenas acentua as capacidades próprias, expandindo tanto a competência como a incompetência. Assim:

- Apenas a compreensão aprofundada permite a verificação dos dados;
- Apenas a verificação possibilita a tomada de decisões com responsabilidade técnica.
\

##### Desenvolvimento do julgamento crítico

A aprendizagem através do esforço próprio desenvolve o julgamento crítico necessário para a utilização correta de ferramentas automáticas ou de IA, permitindo detetar os seus erros.

O esforço cognitivo, incluindo o erro e a respetiva correção, permanece insubstituível na formação em engenharia.
"""
)

	elseif lang == "en"

Foldable("Impact of AI on Engineering Stages", md"""

Generative AI does not alter the essence of engineering; it merely modifies the space in which it takes place.


| Stage | Technical Actions | Nature of Work |
|:---|:---|:---|
| **Formulate** $\qquad\qquad\qquad\qquad$ | Define the correct problem $\qquad\qquad\qquad\qquad$ Choose the model and its validity limits Establish acceptance criteria | Remains human |
| **Execute** $\qquad\qquad\qquad\qquad$ | Calculate; Simulate; Program; Optimize | Increasingly assisted by AI |
| **Validate and decide** | Verify the physical plausibility of the result Interpret the technical implications $\qquad\qquad\qquad$ Assume technical and professional responsibility | Remains human |

\

##### Technical Dependence and Discernment		 

The use of AI tools merely accentuates one's own capabilities, expanding both competence and incompetence. Therefore:

- Only deep understanding enables the verification of data;
- Only verification allows for decision-making with technical responsibility.
\

##### Development of Critical Judgment

Learning through one's own effort develops the critical judgment required for the correct use of automated or AI tools, enabling the detection of their errors.

Cognitive effort, including mistakes and their respective correction, remains irreplaceable in engineering education.
"""
)
	end
end

# ╔═╡ 5681fd9e-75ec-4eaf-a4a1-aee79d844e08


# ╔═╡ c3e6a38f-06de-4241-9561-c549c29ac0c3
begin
	if lang == "pt"

md"""
##### Auto-avaliação

Antes de usares o **Wattutor**, reflete sobre as tuas práticas atuais no uso de IA:
"""

	elseif lang == "en"

md"""
##### Self-Assessment

Before using **Wattutor**, reflect on your current AI usage practices:
"""
	end
end

# ╔═╡ 07527b9c-0049-4ccb-ba73-ec811faac1a1
begin
	if lang == "pt"

@bind uso_atual Select(
    [
        ""  => "👇 Seleciona uma opção...",
        "Nunca usei IA em contexto académico"                                    => "Nunca usei IA em contexto académico",
        "Uso ocasionalmente para esclarecer dúvidas pontuais"                    => "Uso ocasionalmente para esclarecer dúvidas pontuais",
        "Uso regularmente para apoiar o estudo"                                  => "Uso regularmente para apoiar o estudo",
        "Uso intensivamente a IA incluindo para obter respostas diretamente"     => "Uso intensivamente a IA incluindo para obter respostas diretamente"
    ]
)

	elseif lang == "en"

@bind current_usage Select(
    [
        "" => "👇 Select an option...",
        "I have never used AI in an academic context" => "I have never used AI in an academic context",
        "I use it occasionally to clarify specific questions" => "I use it occasionally to clarify specific questions",
        "I use it regularly to support my studying" => "I use it regularly to support my studying",
        "I use AI intensively, including to obtain direct answers" => "I use AI intensively, including to obtain direct answers"
    ]
)
	end
end

# ╔═╡ 9f647d85-ac91-44b8-abe0-650c64d018c6
begin
	if lang == "pt"


		let
			msg = if uso_atual == ""
				( md" ")
				elseif uso_atual == "Nunca usei IA em contexto académico"
				( md"🟢 -- Boa oportunidade para começar de forma consciente. Este _notebook_ é o ponto de partida certo.")
				elseif uso_atual == "Uso ocasionalmente para esclarecer dúvidas pontuais"
				(md"🟢 -- Uso equilibrado. Aproveita as boas práticas de _prompt_ para tirar mais partido.")
				elseif uso_atual == "Uso regularmente para apoiar o estudo"
				(md"🟡 -- Uso regular é produtivo desde que mantenhes o hábito de verificar as respostas criticamente.")
				else
				(md"🔴 -- **Atenção:** usar IA para obter respostas diretas, sem compreender o processo, compromete a aprendizagem e a integridade académica.")
			end
			
			md"""
			$(msg)
			"""
		end
	
	elseif lang == "en"


		let
			msg = if current_usage == ""
				( md" ")
				elseif current_usage == "I have never used AI in an academic context"
				( md"🟢 -- A great opportunity to start mindfully. This *notebook* is the perfect starting point.")
				elseif current_usage == "I use it occasionally to clarify specific questions"
				(md"🟢 -- Balanced usage. Take advantage of prompt best practices to get more out of it.")
				elseif current_usage == "I use it regularly to support my studying"
				(md"🟡 -- Regular use is productive, as long as you maintain the habit of critically verifying the answers.")
				else
				(md"🔴 -- **Warning:** using AI to get direct answers without understanding the process compromises both learning and academic integrity.")
			end

			md"""
			$(msg)
			"""
		end
	end
end

# ╔═╡ d0390b06-d9bb-433a-b817-dfaa70cc124a


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
if lang == "pt"
	md"# Bibliografia Principal"
elseif lang == "en"
	md"# Main Bibliography"
end

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
if lang == "pt"
	md"# Avaliação"
elseif lang == "en"
	md"# Assessment"
end

# ╔═╡ 656887e0-2f78-498a-90ff-eccdab3bc3f5
if lang == "pt"
	md"""
	$\boldsymbol{\mathit{NF}} = 0.45 \times MT+0.50 \times ML+0.05 \times ME$
	
	 $\boldsymbol{\mathit{NF}}$: **Nota Final**\
	 $MT$: Média dos testes (ou nota do exame)\
	 $ML$: Média ponderada dos Trabalhos Laboratoriais $(TL)$\
	 $ME$: Nota da apresentação da Máquina Elétrica Especial $\rm{(MEE)}$
	
	$ML=\frac{\sum\limits_{i=1}^{5} TL_i \times P_i}{\sum\limits_{i=1}^{5} P_i}$
	
	 $P_i$: peso baseado no número de aulas práticas necessárias para cada trabalho
	
	**Componentes facultativas:** $\rm{MEE}$ e $TL_5$.
	"""
elseif lang == "en"
	md"""
	$\boldsymbol{\mathit{FG}}=0.45 \times TA+0.50 \times LA+0.05 \times SM$
	
	 $\boldsymbol{\mathit{FG}}$: **Final Grade**\
	 $TA$: Tests Average (or exam grade)\
	 $LA$: Laboratory Assignments Weighted Average\
	 $SM$: Special Electrical Machine $\rm{(SEM)}$ presentation grade 
	
	$LA=\frac{\sum\limits_{i=1}^{5} LA_i \times W_i}{\sum\limits_{i=1}^{5} W_i}$
	
	 $W_i$: weight based on the number of practical classes required for each assignment
	
	**Optional components:** $\rm{SEM}$ and $LA_5$.
	"""
end

# ╔═╡ cf6d97ec-e94b-4ec8-8b08-2e596b5624a4
if lang == "pt"
   md"# Referências"
elseif lang == "en"
   md"# References"
end

# ╔═╡ f6c8f4cb-66a3-4879-8a17-85c37bab2701
md"""
[^Tidema]: Tidema, [A visual representation of Bloom's revised taxonomy, with indications of possible classroom activities associated with each level.](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Bloom%27s_revised_taxonomy.svg/512px-Bloom%27s_revised_taxonomy.svg.png?20240919191759), [CC BY 4.0](https://creativecommons.org/licenses/by/4.0), via *Wikimedia Commons*.

[^Bezjak_2018]: Sonja Bezjak, April Clyburne-Sherin, Philipp Conzett, Pedro Fernandes, Edit Görögh, Kerstin Helbig, Bianca Kramer, Ignasi Labastida, Kyle Niemeyer, Fotis Psomopoulos, Tony Ross-Hellauer, René Schneider, Jon Tennant, Ellen Verbakel, Helene Brinken, & Lambert Heller. (2018). [The Open Science Training Handbook](https://open-science-training-handbook.gitbook.io/book). [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1212496.svg)](https://doi.org/10.5281/zenodo.1212496)
"""

# ╔═╡ 79b6d4b5-4617-4084-81fe-a06d1c728c06


# ╔═╡ c251fd12-11b6-4649-898d-70dba9f9e976
if lang == "pt"
	md"# Anexo: árvore das ME"
elseif lang == "en"
	md"# Appendix: EM tree"
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
	if lang == "pt"
		md"Destape (👁) para visualizar..."
	elseif lang == "en"
		md"Click (👁) to view..."
	end
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

# ╔═╡ 5b3c89b5-a757-4709-9bdb-f3e0feff5da1
if lang == "pt"
   md"# *Notebook*"
elseif lang == "en"
   md"# Notebook"
end

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
	TableOfContents(title="Índice", depth=2)
elseif lang == "en"
	TableOfContents(depth=2)
end

# ╔═╡ 8c3e700e-4db1-4e2e-a0d1-b7c2cf724b74
md"""
|  |  |
|:--:|:--|
|  | This notebook, [ME-II.jl](https://ricardo-luis.github.io/me-2/ME-II.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2027 [Ricardo Luís](https://ricardo-luis.github.io/) |
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

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "4915aa0104a7a2030126c0b4dcc32ca49c6d0b7f"

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
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

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

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

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
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

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
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

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
version = "2025.11.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

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
version = "1.12.1"

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
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

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

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
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
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"
"""

# ╔═╡ Cell order:
# ╟─d3541bae-bcdb-4e58-89ce-3ad5204e5e56
# ╟─399c7a6d-88da-4966-a524-9a00491809a1
# ╟─117c889a-2c0a-4648-befb-4067cb0869a1
# ╟─20e8ef2a-b923-4e9d-86c8-53aafcd2d8e3
# ╟─797e2cea-ff51-43b2-8d5b-29c6740ec9c5
# ╟─4a679083-ab50-414c-b0e7-1c1ca50f53a0
# ╟─6dd8ad18-9069-4500-bc84-51e502d57c37
# ╟─596dca72-e55b-4559-862b-0807defad8a2
# ╟─689fbf6c-8504-4648-a1da-cf5049fa5310
# ╟─dce5565f-b004-489d-827b-b0af02c3cc6b
# ╟─7cda7c65-c1e5-4038-8414-406b30da4675
# ╟─250883b0-68da-46e8-8159-d478587e7c31
# ╟─f0b7a6b5-a87f-4c54-aff8-f23f5c6f726f
# ╟─364d1e59-c671-41ba-9be9-83aa1e167208
# ╟─eb8ba078-3c71-4f50-8964-d4cadb20af2e
# ╟─aaaf7c2e-c16d-43d9-9cbc-f651c67e93c4
# ╟─42ee7dfc-33da-40eb-b595-2ae450708bc8
# ╟─4d848824-62a6-4898-a4af-72e6b1bf3603
# ╟─829944ba-ae63-423e-a7ab-cbf03c387084
# ╟─43ae90f4-7178-4fe0-a998-6285f268aba0
# ╟─aed1be60-b09d-4683-ad65-5ecb3e21cb4c
# ╟─dc79aea5-428a-4af3-8f49-293896aad766
# ╟─ecfea3f4-6a77-4cb1-8254-0c8a6d1651cb
# ╟─562c4904-227a-4950-bbb5-dfa43c8e778b
# ╟─69669b2a-bc2c-4311-8437-f046bb5bc9c3
# ╟─5681fd9e-75ec-4eaf-a4a1-aee79d844e08
# ╟─c3e6a38f-06de-4241-9561-c549c29ac0c3
# ╟─07527b9c-0049-4ccb-ba73-ec811faac1a1
# ╟─9f647d85-ac91-44b8-abe0-650c64d018c6
# ╟─d0390b06-d9bb-433a-b817-dfaa70cc124a
# ╟─d6816245-7d61-4136-91f0-e8c480665278
# ╟─689dad68-fd9d-4e6b-8adc-029ca1f08ccc
# ╟─b8c5ca70-be9d-464e-8489-fd41b8445952
# ╟─90cc6fe9-0a65-4a61-93a2-296c416db981
# ╟─b1289346-6bbe-46a0-9721-c51acdf6e362
# ╟─6538fe16-97a6-4886-8253-2f40593d4d81
# ╟─fba9f05c-7b5f-4f7c-bcd6-608ff25ff634
# ╟─57166d2c-e6c5-4b74-8103-7746e3ace7f2
# ╟─656887e0-2f78-498a-90ff-eccdab3bc3f5
# ╟─cf6d97ec-e94b-4ec8-8b08-2e596b5624a4
# ╟─f6c8f4cb-66a3-4879-8a17-85c37bab2701
# ╟─79b6d4b5-4617-4084-81fe-a06d1c728c06
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
