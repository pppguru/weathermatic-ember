`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

ProgramSerializer = ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs:
    programStartTimes:
      serialize: 'records'
      deserialize: 'records'
    smartlinkController:
      serialize: false
      deserialize: 'id'
    programSeasonalAdjustments:
      serialize: false
      deserialize: 'records'

  normalizeLinks: (data) ->
    data.smartlink_controller_id = data.controller_id
    delete data.controller_id
    this._super(arguments...)
})

`export default ProgramSerializer`
