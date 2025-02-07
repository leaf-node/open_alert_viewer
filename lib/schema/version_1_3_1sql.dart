/*
 * spdx-filecopyrighttext: 2024 open alert viewer authors
 *
 * spdx-license-identifier: mit
 */

final version_1_3_1sql = """

alter table alerts_cache add column monitor_url TEXT NOT NULL DEFAULT "";

""";
