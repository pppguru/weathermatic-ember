`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditZoneRainSensorController = Ember.Controller.extend(SmartlinkSaveMixin, {

  saveUrl: Ember.computed 'model.id', ->
    "#{@get('baseUrl')}/api/v2/controllers/#{@get('model.id')}/update_advanced_settings"

  zoneUsesRainSensorDidChange: Ember.observer('model.zones.@each.usesRainSensor', ->
    this.send('save')
  )

  actions:
    save: ->
      zoneParams = {}
      @get('model.zones').forEach (zone) ->
        key = "zone-#{zone.get('id')}-ignore-rain"
        if zone.get('usesRainSensor')
          zoneParams[key] = 'off'
        else
          zoneParams[key] = 'on'

      @save(
        showLoadingModal: false
        url: @get('saveUrl')
        params: zoneParams
      ).then( =>
        @set('model.hasUnsentChanges', true)
      )

})

`export default SmartlinkControllerSettingsEditZoneRainSensorController`
