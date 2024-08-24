/**
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "fast_stage_2" {
  description = "FAST stages 2 configurations."
  type = object({
    networking = optional(object({
      enabled    = optional(bool, true)
      short_name = optional(string, "net")
      cicd_config = optional(object({
        identity_provider = string
        repository = object({
          name      = string
          branch    = optional(string)
          parent_id = optional(string)
          type      = optional(string, "github")
        })
      }))
      folder_config = optional(object({
        create_env_folders = optional(bool, true)
        iam_by_principals  = optional(map(list(string)), {})
        name               = optional(string, "Networking")
        parent_id          = optional(string)
      }), {})
    }), {})
    project_factory = optional(object({
      enabled    = optional(bool, true)
      short_name = optional(string, "pf")
      cicd_config = optional(object({
        identity_provider = string
        repository = object({
          name   = string
          branch = optional(string)
          type   = optional(string, "github")
        })
      }))
    }), {})
    security = optional(object({
      enabled    = optional(bool, true)
      short_name = optional(string, "sec")
      cicd_config = optional(object({
        identity_provider = string
        repository = object({
          name   = string
          branch = optional(string)
          type   = optional(string, "github")
        })
      }))
      folder_config = optional(object({
        create_env_folders = optional(bool, false)
        iam_by_principals  = optional(map(list(string)), {})
        name               = optional(string, "Security")
        parent_id          = optional(string)
      }), {})
    }), {})
  })
  nullable = false
  default  = {}
  # TODO: CI/CD validation
}

variable "fast_stage_3" {
  description = "FAST stages 3 configurations."
  type = map(object({
    short_name = optional(string)
    cicd_config = optional(object({
      identity_provider = string
      repository = object({
        name   = string
        branch = optional(string)
        type   = optional(string, "github")
      })
    }))
    folder_config = optional(object({
      name               = string
      create_env_folders = optional(bool, false)
      iam_by_principals  = optional(map(list(string)), {})
      parent_id          = optional(string)
      tag_bindings       = optional(map(string), {})
    }))
    organization_iam_roles = optional(object({
      ro = optional(list(string), [])
      rw = optional(list(string), [])
    }), {})
    stage2_iam_roles = optional(object({
      networking = optional(object({
        ro = optional(list(string), [])
        rw = optional(list(string), [])
      }), {})
      security_iam_roles = optional(object({
        ro = optional(list(string), [])
        rw = optional(list(string), [])
      }), {})
    }), {})
  }))
  nullable = false
  default = {
    # data-platform = {
    #   short_name = "dp"
    #   folder_config = {
    #     name               = "Data Platform"
    #     create_env_folders = true
    #   }
    # }
    # gcve = {
    #   folder_config = {
    #     name               = "GCVE"
    #     create_env_folders = true
    #   }
    # }
    # gke = {
    #   folder_config = {
    #     name               = "GKE"
    #     create_env_folders = true
    #   }
    # }
  }
  # TODO: CI/CD validation
}