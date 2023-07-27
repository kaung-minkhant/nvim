local status_ok, jsonSchema = pcall(require, 'schemastore')
if not status_ok then
  return
end


return {
  settings = {
    json = {
      schemas = jsonSchema.json.schemas(),
--      validate = { enable = true },
    },
  },
}
