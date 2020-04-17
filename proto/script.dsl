values {
  trees 5
  lumberjacks 8
  logs 0 {
    <= 0.0001 Message = "No logs for the mushrooms to grow on!"
  }
  nutrients 0 {
    >= 10.0 nutrient_knowledge = 1.0
  }
  mushrooms 2 {
    < 1 Message = "No mushrooms left to decompose logs into nutrients"
  }
}
actions {
  drop_seeds 1 * (trees * 10) {
    nutrients - 10 stopat 0
    seedlings + 1
  }
  cut_trees 0.005 * lumberjacks {
    trees - 1 stopat 0
    logs + 10
  }
  sprout 1 * seedlings {
    nutrients - 990 stopat 0
    seedlings - 1 stopat 0
    trees + 1
  }
  seed_fail 1 * seedlings {
    seedlings - 1 stopat 0
    nutrients + 10
  }
  mushroom_decompose 0.01 * mushrooms {
    logs - 0.01 stopat 0
    nutrients + 1
  }
  mushroom_death 0.005 * (mushrooms*10) {
    mushrooms - 1 stopat 0
    nutrients + 1
  }
  mushroom_birth 0.1 * mushrooms {
    logs - 0.01 stopat 0
    mushrooms + 1
  }
  remove_lumberjack 1 * 0 {
    lumberjacks - 1 stopat 4
  }
  add_lumberjack 1 * 0 {
    lumberjacks + 1 stopat 10
  }
  add_seedling 1 * 0 {
    seedlings + 1
    nutrients - 10 stopat 0
  }
  add_mushroom 1 * 0 {
    mushrooms + 1
    nutrients - 1 stopat 0
  }
}
interfaces {
  tree 1
  groups [ resources ]
  values [ trees ]
  labels [ "Trees" ]
  buttons {}

  lumberjack 1
  groups [ resources ]
  values [ lumberjacks ]
  labels [ "Lumberjacks" ]
  buttons {}

  log 1
  groups [ resources ]
  values [ logs ]
  labels [ "Logs" ]
  buttons {}

  seedling 1
  groups [ resources ]
  values [ seedlings ]
  labels [ "Seedlings" ]
  buttons {}

  nutrient nutrient_knowledge
  groups [ resources ]
  values [ nutrients ]
  labels [ "Nutrients" ]
  buttons {}

  mush 1
  groups [ resources ]
  values [ mushrooms ]
  labels [ "Mushrooms" ]
  buttons {}

  destroy_ljack (lumberjacks + (-4))
  groups [ buttons ]
  values []
  labels []
  buttons {
    "-Lumberjacks" remove_lumberjack
  }

  create_ljack 1
  groups [ buttons ]
  values []
  labels []
  buttons {
    "+Lumberjacks" add_lumberjack
  }

  create_seedling 1
  groups [ buttons ]
  values []
  labels []
  buttons {
    "Plant seedling" add_seedling
  }

  create_mushroom 1
  groups [ buttons ]
  values []
  labels []
  buttons {
    "Plant mushroom" add_mushroom
  }
}
groups {
  Resource [ resources ]
  Button [ buttons ]
}
