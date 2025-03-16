%dw 2.0
output application/json
import try, orElseTry from dw::Runtime 
---
(vars.result map ((item, index) -> item mapObject ((value, key, index) -> try(() -> (key): read(value, 'application/json')) orElseTry ((key): value) ))) map ((item, index) -> item.*result reduce ((item, acc={}) -> acc ++ item))
