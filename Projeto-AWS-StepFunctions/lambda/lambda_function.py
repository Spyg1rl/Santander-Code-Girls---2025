def lambda_handler(event, context):
    # event: dados que o Step Functions envia
    name = event.get("name", "Mundo")
    message = f"Olá, {name} — sua tarefa foi executada com sucesso!"
    # retornar algo que a máquina de estados pode usar depois
    return {"message": message, "inputReceived": event}
