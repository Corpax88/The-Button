extends SceneTree

var failed := false

func check(condition: bool, message: String) -> void:
    if condition:
        print("PASS: ", message)
    else:
        failed = true
        push_error("FAIL: " + message)

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var packed := load("res://main.tscn")
    check(packed != null, "main scene loads")
    if packed == null:
        quit(1)
        return
    var scene = packed.instantiate()
    root.add_child(scene)
    await process_frame
    await process_frame
    check(scene.main_button != null, "main button exists")
    check(scene.behaviors.size() >= 20, "adaptive behavior pool loaded")
    check(scene.modifiers.size() >= 10, "modifier pool loaded")
    check(scene.successes >= 0, "progress initialized")
    print("SELFTEST_RESULT=", "FAIL" if failed else "PASS")
    quit(1 if failed else 0)
