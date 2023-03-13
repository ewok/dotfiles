(fn config []
  (let [com (require :Comment)]
    (com.setup {:opleader {:line :gc :block :gb}
                :toggler {:line :gcc :block :gcb}
                :extra {:above :gck :below :gcj :eol :gcA}})))

{: config}
