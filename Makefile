env    = PATH=./env/bin:${PATH}
image  = biobox_testing/abyss

ssh: .image env
	@$(env) biobox login short_read_assembler $(image)

test: .image env
	@$(env) biobox verify short_read_assembler $(image) --verbose
	@$(env) biobox verify short_read_assembler $(image) --verbose --task=adaptive

build: .image

.image: $(shell find image -type f) Dockerfile
	@docker build --tag $(image) .
	@touch $@

env:
	@virtualenv -p python3 $@
	@$@/bin/pip install biobox_cli
