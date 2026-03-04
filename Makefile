create-dev:
	make setup-python-dev
	make setup-web-dev
	make setup-hooks-dev

setup-python-dev:
	python3.13 -m venv venv
	source venv/bin/activate && pip install -r requirements.txt && pip install -r requirements-dev.txt

setup-web-dev:
	cd web && pnpm install

setup-hooks-dev:
	pre-commit install
	pre-commit install --hook-type pre-push
